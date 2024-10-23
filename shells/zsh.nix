{
  config,
  pkgs,
  enabled,
  ...
}:
{
  programs.zsh = {
    enable = enabled;
    # enableAutosuggestions = true;
    # syntaxHighlighting.enable = true;
    enableCompletion = true;
    # initExtra = ''
    #   # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    #   # Initialization code that may require console input (password prompts, [y/n]
    #   # confirmations, etc.) must go above this block; everything else may go below.
    #   if [[ -r "\$\{XDG_CACHE_HOME:-$HOME/.cache\}/p10k-instant-prompt-\$\{(%):-%n\}.zsh" ]]; then
    #     source "\$\{XDG_CACHE_HOME:-$HOME/.cache\}/p10k-instant-prompt-\$\{(%):-%n\}.zsh"
    #   fi

    #   # If you come from bash you might have to change your $PATH.
    #   # export PATH=$HOME/bin:/usr/local/bin:$PATH

    #   # Path to your oh-my-zsh installation.
    #   export ZSH="${pkgs.oh-my-zsh}/.oh-my-zsh"
    #   export KEVIN_NVIM_HOME="/Users/tungchinchen"

    #   # completion using arrow keys (based on history)
    #   bindkey '^[[A' history-search-backward
    #   bindkey '^[[B' history-search-forward
    # '';
    # theme = "powerlevel10k/powerlevel10k";
    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [
    #     "git"
    #     "zsh-nvm"
    #     "vi-mode"
    #   ];
    # };
  };
}
