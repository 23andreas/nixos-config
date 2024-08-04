{
  description = "NixOS Config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags.url = "github:Aylur/ags";
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cachix-deploy.url = "github:cachix/cachix-deploy-flake";

    walker.url = "github:abenz1267/walker";
    mcmojave-hyprcursor.url = "github:libadoxon/mcmojave-hyprcursor";
  };

  nixConfig = {
    extra-substituters = [
      "https://23andreas.cachix.org"
    ];
    extra-trusted-public-keys = [
      "23andreas.cachix.org-1:P9ng+DdiASGCO+NbxXnfeWPh66pvkb62xsRAN30JyTc="
    ];
  };

  outputs = { self, nixpkgs, home-manager, disko, cachix-deploy, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      cachix-deploy-lib = cachix-deploy.lib pkgs;

    in
    {
      nixosConfigurations =
        {
          iso = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ({ pkgs, modulesPath, ... }: {
                imports = [
                  "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
                  "${modulesPath}/installer/cd-dvd/channel.nix"
                ];
                isoImage.squashfsCompression = "gzip -Xcompression-level 1";

                systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
                users.users.root.openssh.authorizedKeys.keys = [
                  #home-lab
                  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICOZWSjNZelhP3CAaIrmLiMMeaTP6EqPz+m6WDVh1meX"
                ];
              })
            ];
          };
          home-desktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              ./system/hosts/home-desktop/configuration.nix
              home-manager.nixosModules.default
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit inputs; };
                  users.andreas = import ./home/users/andreas.nix;
                };
              }
            ];
          };
          work-laptop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              disko.nixosModules.disko
              # nixos-hardware.nixosModules.dell-xps-15-9510
              ./system/hosts/work-laptop/configuration.nix
              home-manager.nixosModules.default
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit inputs; };
                  users.andreas = import ./home/users/andreas.nix;
                };
              }
            ];
          };
        };

      packages."x86_64-linux" = {
        cachix-deploy-spec = cachix-deploy-lib.spec {
          agents = {
            andreas-home-desktop = self.nixosConfigurations.home-desktop.config.system.build.toplevel;
            andreas-work-laptop = self.nixosConfigurations.work-laptop.config.system.build.toplevel;
          };
        };
      };

      top =
        let
          nixtop = inputs.nixpkgs.lib.genAttrs
            (builtins.attrNames inputs.self.nixosConfigurations)
            (attr: inputs.self.nixosConfigurations.${attr}.config.system.build.toplevel);
        in
        nixtop;
    };
}

