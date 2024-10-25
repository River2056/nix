{
  config,
  pkgs,
  ...
}:
{
  programs.tmux = {
    enable = false;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    mouse = true;
    plugins = with pkgs; [
      tmuxPlugins.tmux-fzf
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      {
        plugin = tmuxPlugins.power-theme;
        extraConfig = ''
          set -g @tmux_power_theme 'gold'
        '';
      }
    ];
    keyMode = "vi";
    clock24 = true;
    extraConfig = ''
      # set-option -sa terminal-overrides ",xterm*:Tc"

      # set prefix
      # unbind C-b
      # set -g prefix C-Space
      # bind C-Space send-prefix

      # navigation between windows
      bind -n Ó previous-window
      bind -n Ò next-window

      # resize panes
      bind-key -r ∆ resize-pane -D 1
      bind-key -r ˚ resize-pane -U 1
      bind-key -r ˙ resize-pane -L 1
      bind-key -r ¬ resize-pane -R 1

      # swap windows
      bind-key -n ¯ swap-window -t -1\; select-window -t -1
      bind-key -n ˘ swap-window -t +1\; select-window -t +1

      ## Use vim keybindings in copy mode
      set-option -g mouse on
      setw -g mode-keys vi
      # set-option -s set-clipboard off
      bind P paste-buffer
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      unbind -T copy-mode-vi Enter
      bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel 'xclip -se c -i'
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'xclip -se c -i'

      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      # run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
