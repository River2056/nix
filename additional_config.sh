echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc

# history setup
his= $(cat <<"EOF"
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
EOF
)
echo "$his">> ~/.zshrc

echo "eval \"$(zoxide init --cmd cd zsh)\"" >> ~/.zshrc
echo "alias ls=\"eza --icons=always\"" >> ~/.zshrc
echo "export EDITOR=nvim" >> ~/.zshrc
echo "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'" >> ~/.zshrc
