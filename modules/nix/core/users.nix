{ pkgs, config, inputs, lib, ... }:

with lib;
let
  users = config._23andreas.users;
  hostname = config._23andreas.hostname;

  userType = types.attrsOf (types.submodule {
    options = {
      groups = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "List of groups the user should belong to.";
      };

      homeManagerFile = mkOption {
        type = types.str;
        default = "";
        description = "Home manager configuration file";
      };

      description = mkOption {
        type = types.str;
        default = "";
        description = "User description";
      };

      nixSettingsAllowed = mkOption {
        type = types.bool;
        default = false;
        description = "Whether the user is allowed to modify Nix settings.";
      };
    };
  });

in {
  options._23andreas.users = mkOption {
    type = userType;
    default = {};
    description = "Users configuration";
  };

  imports = [ inputs.home-manager.nixosModules.home-manager ];
  config = {

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      extraSpecialArgs = { inherit inputs users hostname; };

      users = builtins.listToAttrs (map (username: {
        name = username;
        value = let
          user = users.${username};
          homeManagerFile = if user ? homeManagerFile && user.homeManagerFile != "" then user.homeManagerFile else "${username}.nix";
        in {
          imports = [ ../../home-manager/users/${homeManagerFile} ];

          home.username = username;
          home.homeDirectory = "/home/${username}";
          home.stateVersion = "23.11";
          programs.home-manager.enable = true;
        };
      }) (builtins.attrNames users));
    };

   users.users = builtins.listToAttrs (map (username: {
      name = username;
      value = let
        user = users.${username};
        userDescription = if user ? description && user.description != "" then user.description else username;
      in {
        hashedPasswordFile = config.sops.secrets."users/${username}/hashed_password".path;
        isNormalUser = true;
        description = userDescription;
        extraGroups = user.groups;
        shell = pkgs.fish;
      };
    }) (builtins.attrNames users));

    nix.settings.allowed-users =
      builtins.filter (username:
        let user = users.${username};
        in user ? nixSettingsAllowed && user.nixSettingsAllowed
      ) (builtins.attrNames users);
  };
}

