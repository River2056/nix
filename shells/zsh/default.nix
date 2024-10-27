{
  config,
  pkgs,
  lib,
  user,
  profileDir,
  ...
}:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      l = "ls -lah";
      la = "ls -lAh";
      lg = "lazygit";
      ll = "ls -lh";
      ls = "eza --icons=always";
      lsa = "ls -lah";
      mux = "tmuxinator";
      vi = "nvim";
      cat = "bat";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];
    autosuggestion = {
      enable = true;
      highlight = "fg=5";
    };
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "vi-mode"
      ];
    };
    history = {
      path = "$HOME/.zhistory";
      share = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };
    historySubstringSearch.searchUpKey = [ "^[[A" ];
    historySubstringSearch.searchDownKey = [ "^[[B" ];
    # initExtraFirst = # bash
    #   ''
    #     # eval "$(brew shellenv)"
    #   '';
    initExtra = lib.concatStrings [
      (builtins.readFile (./. + "/extra.sh"))
    ];
  };
}
