{
  description = "NixOS Config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
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
    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cachix-deploy.url = "github:cachix/cachix-deploy-flake";

    catppuccin.url = "github:catppuccin/nix";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
  };

  nixConfig = {
    extra-substituters = [
      "https://23andreas.cachix.org"
    ];
    extra-trusted-public-keys = [
      "23andreas.cachix.org-1:P9ng+DdiASGCO+NbxXnfeWPh66pvkb62xsRAN30JyTc="
    ];
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      nixos-hardware,
      cachix-deploy,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      cachix-deploy-lib = cachix-deploy.lib pkgs;
      cachixDeployments = [
        "server"
        "work-laptop"
        "home-desktop"
      ];
    in
    {
      nixosConfigurations = {

        iso = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ (import ./iso/nixos-installer-iso.nix) ];
        };

        home-desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ (import ./hosts/home-desktop) ];
          specialArgs = { inherit self inputs; };
        };

        work-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ (import ./hosts/work-laptop) ];
          specialArgs = {
            inherit
              self
              inputs
              disko
              nixos-hardware
              ;
          };
        };

        server = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ (import ./hosts/server) ];
          specialArgs = { inherit self inputs disko; };
        };
      };

      packages.${system} = {
        cachix-deploy-spec = cachix-deploy-lib.spec {
          agents = inputs.nixpkgs.lib.genAttrs cachixDeployments (
            attr: inputs.self.nixosConfigurations.${attr}.config.system.build.toplevel
          );
        };
      };

      top =
        let
          nixtop = inputs.nixpkgs.lib.genAttrs (builtins.attrNames inputs.self.nixosConfigurations) (
            attr: inputs.self.nixosConfigurations.${attr}.config.system.build.toplevel
          );
        in
        nixtop;
    };
}
