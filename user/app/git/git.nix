{ config, pkgs, userSettings, ... }:

{
  home.packages = [ pkgs.git pkgs.gh pkgs.github-desktop ];

  programs.git.enable = true;
  programs.git.userName = userSettings.name;
  programs.git.userEmail = userSettings.email;
  programs.git.extraConfig = {
    init.defaultBranch = "main";
    safe.directory = [ ("/home/" + userSettings.username + "/.dotfiles") ("/home/" + userSettings.username + "/.dotfiles/.git") ];
  };

  programs.gh = {
    enable = true;
    settings = {
      version = "1";
      aliases = {
        "as" = "auth status";
        "al" = "auth login";
      };
      gitCredentialHelper.enable = true;
      extensions = with pkgs; [
        gh-dash
        gh-notify
        gh-copilot
        gh-screensaver
        gh-actions-cache
        gh-markdown-preview
        gh-eco
        gh-cal
        gh-s
        gh-f
      ];
    };
  };
}
