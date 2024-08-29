{ pkgs, config, inputs, lib, ... }:

with lib;
let
  users = config._23andreas.users;
  hostname = config._23andreas.hostname;

  userType = types.attrsOf (
    types.submodule {
      options = {
        description = mkOption {
          type = types.str;
          default = "";
          description = "User description";
        };

        hashedPasswordFile = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "Path to a file containing the hashed password for the user.";
        };

        # sshAuthorizedKeyFiles = mkOption {
        #   type = types.listOf types.str;
        #   default = [];
        #   description = "An SSH public key to authorize for this user.";
        # };

        sshAuthorizedKeys = mkOption {
          type = types.listOf types.str;
          default = [];
          description = "SSH Public keys to authorize for this user";
        };

        groups = mkOption {
          type = types.listOf types.str;
          default = [ ];
          description = "List of groups the user should belong to.";
        };

        homeManagerFile = mkOption {
          type = types.nullOr types.path;
          default = null;
          description = "Home manager configuration file";
        };

        nixSettingsAllowed = mkOption {
          type = types.bool;
          default = false;
          description = "Whether the user is allowed to modify Nix settings.";
        };
      };
    }
  );

  usersWithHomeManager = filter (username: users.${username}.homeManagerFile != null) (builtins.attrNames users);
  hasUsersWithHomeManager = length usersWithHomeManager > 0;

in {
  options._23andreas.users = mkOption {
    type = userType;
    default = { };
    description = "Users configuration";
  };

  imports = [ inputs.home-manager.nixosModules.home-manager ];

  config = {
    home-manager = mkIf hasUsersWithHomeManager {
      useUserPackages = true;
      useGlobalPkgs = true;
      extraSpecialArgs = {
        inherit inputs users hostname;
      };
      users = builtins.listToAttrs (
        map (username: {
          name = username;
          value = {
              imports = [ users.${username}.homeManagerFile ];
              home.username = username;
              home.homeDirectory = "/home/${username}";
              home.stateVersion = "23.11";
              programs.home-manager.enable = true;
          };
        }) usersWithHomeManager
      );
    };

    users.users = builtins.listToAttrs (
      map (username: {
        name = username;
        value = {
          isNormalUser = true;
          description = users.${username}.description;
          extraGroups = users.${username}.groups;
          shell = pkgs.fish;
          hashedPasswordFile = users.${username}.hashedPasswordFile;
          openssh.authorizedKeys.keys = users.${username}.sshAuthorizedKeys;
          # openssh.authorizedKeys.keyFiles = users.${username}.sshAuthorizedKeyFiles;
        };
      }) (builtins.attrNames users)
    );

    nix.settings.allowed-users = builtins.filter (
      username:
        users.${username} ? nixSettingsAllowed && users.${username}.nixSettingsAllowed
    ) (builtins.attrNames users);
  };
}

