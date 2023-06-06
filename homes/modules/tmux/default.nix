{
  config,
  lib,
  pkgs,
  my-dotfiles,
  ...
}: {
  
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
  };

  home.packages = with pkgs; [];
}