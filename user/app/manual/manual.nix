{ config, pkgs, userSettings, ... }:

{
  manual = {
    # Description
    # Whether to install the HTML manual. This also installs the
    # {command}home-manager-help tool, which opens a local
    # copy of the Home Manager manual in the system web browser.
    html.enable = true;
    # Description
    # Whether to install a JSON formatted list of all Home Manager
    # options. This can be located at
    # {file}/share/doc/home-manager/options.json,
    # and may be used for navigating definitions, auto-completing,
    # and other miscellaneous tasks.
    json.enable = true;
    # Description
    # Whether to install the configuration manual page. The manual can
    # be reached by {command}man home-configuration.nix.

    # When looking at the manual page pretend that all references to
    # NixOS stuff are actually references to Home Manager stuff.
    # Thanks!
    manpages.enable = true;
  };

  programs.man = {
    enable = true;
    package = pkgs.man;
    generateCaches = true;
  };
}
