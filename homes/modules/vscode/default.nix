{
  config,
  lib,
  pkgs,
  my-dotfiles,
  ...
}: {

  programs.vscode = {
    enable = true;
  };

  home.packages = with pkgs; [];
}