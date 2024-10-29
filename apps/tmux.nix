{
  config,
  pkgs,
  profileDir,
  ...
}:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    mouse = true;
    customPaneNavigationAndResize = true;
    plugins = with pkgs; [
      tmuxPlugins.tmux-fzf
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      {
        plugin = tmuxPlugins.power-theme;
        extraConfig = # bash
          ''
            set -g @tmux_power_theme 'gold'
          '';
      }
    ];
    keyMode = "vi";
    clock24 = true;
    extraConfig = ''
      # set-option -sa terminal-overrides ",xterm*:Tc"
      set -g default-command "${pkgs.zsh}/bin/zsh -l"
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # set prefix
      unbind C-b
      set -g prefix C-s
      bind C-s send-prefix
      set-option -g prefix2 C-b

      bind s split-window -v
      bind v split-window -h

      # navigation between windows
      bind -n Ó previous-window
      bind -n Ò next-window

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
    '';
  };
}
