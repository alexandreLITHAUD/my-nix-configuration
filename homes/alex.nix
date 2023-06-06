{ nixpkgs
, options
, modulesPath
, lib
, config
, home-module
, pkgs
, my-dotfiles
,
}: {

  import = [
    ./modules/git
    ./modules/tmux
    ./modules/vscode
    ./module/zsh
  ];

  config = {

    nixpkgs.config.allowUnfree = true;
    # https://github.com/nix-community/home-manager/issues/2942#issuecomment-1119760100
    nixpkgs.config.allowUnfreePredicate = pkg: true;
    # First we activate home-manager
    programs.home-manager.enable = true;

    # programs.zsh.enable = true;
    programs.bash = {
      enable = true;
      initExtra = ''
      '';
    };

    programs.ssh = {
      enable = true;
      extraConfig = builtins.readFile "${my-dotfiles}/files/ssh/ssh_config";
    };

    home.packages = with pkgs; [
      # Web
      firefox

      bat # cat with colors for code
      cloc

      tree
      man-pages
      gcc
      wget
      gdb
      pandoc
      tdld
      ranger

      # Nix file formating
      nixpkgs-fmt

      # GUI applications
      # calibre
      spotify
      discord
      libreoffice

      # Password manager
      bitwarden

      ## PROJECT TODO DELETE
      egl-wayland
      cmake
      vde2
      kvmtool
      qemu_kvm
    ];

  };
}
