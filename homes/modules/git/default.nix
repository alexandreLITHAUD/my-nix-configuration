{ config
, lib
, pkgs
, my-dotfiles
, ...
}: {

  programs.git = {
    enable = true;
    extraConfig = builtins.readFile "${my-dotfiles}/files/git/gitconfig";
  };

  home.packages = with pkgs; [];
}
