{ config, pkgs, userSettings, ... }:

{
  home.packages = [ pkgs.bat ];
  programs.bat = {
    enable = true;
    config = {
      theme = "github";
      italic-text = "always";
    };
  };
}
