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

      # mac_ibm specific
      m = "make";
      mc = "make clean run";
      mcd = "make clean debug";
      note = "nb edit 4";
      r2ftp = "lftp -u 'T-EBANK,!QAZ2wsx' 172.17.240.203";
      rftp = "lftp -u EBTWAS,Tb03750168@ 172.16.241.118";
      sit = "sshpass -p '>LO(/;p0' ssh nanoadmin@172.16.244.154";
      uat = "sshpass -p '>LO(/;p0' ssh nanoadmin@172.16.244.210";
      pt = "sshpass -p '>LO(/;p0' ssh ainkpdadmin@172.16.244.154";
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
    initExtraFirst = # bash
      ''
         eval "$(brew shellenv)"
      '';
    initExtra = lib.concatStrings [
      (builtins.readFile (./. + "/extra.sh"))
      (builtins.readFile (./. + "/custom_functions.sh"))
    ];
  };
}
