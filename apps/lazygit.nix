{ config, pkgs, ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      gui.language = "en";
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
    };
  };
}
