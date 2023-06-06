{ config
, lib
, pkgs
, my-dotfiles
, ...
}:
let
  zshrc = builtins.readFile "${my-dotfiles}/files/zshrc";
in
{

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    shellAliases = {
      r = "ranger";
      f = "fzf";
      v = "vim";
      vim = "nvim";
      cat = ''bat --paging=never --style="plain"'';
    };

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "tig" "sudo" "web-search" "copyfile" "colored-man-pages" "themes" ];
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    zsh-completions
    zsh-navigation-tools
    tig
    zsh
    any-nix-shell
  ];

}
