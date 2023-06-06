{
  description = "My nix configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    my-dotfiles = {
      url = "github:alexandreLITHAUD/my-dotfiles";
      flake = false;
    };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixos-unstable";
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , nixos-unstable
    , my-dotfiles
    , home-manager
    }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      unstable = import nixos-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      # Activate with: home-manager --flake .#alex switch
      homeConfigurations =
        let
          home-module = {
            nixpkgs.config.allowUnfree = true;
            home = rec {
              username = "alex";
              homeDirectory = "/home/${username}";
              stateVersion = "23.05";
            };
          };
        in
        {
          alex = home-manager.lib.homeManagerConfiguration rec {
            inherit my-dotfiles pkgs;
            modules = [
              home-module
              ./homes/alex.nix
            ];
          };
        };

      nixosConfigurations = {
        # Configuration for my current working machine.
        alex = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          # extra arguments will be injected into the modules.
          extraArgs = { inherit my-dotfiles; };
          modules = [
            # Main configuration, includes the hardware file and the module list
            ./deployments/configuration-alex_conf.nix
          ];
        };
      };
    };
}
