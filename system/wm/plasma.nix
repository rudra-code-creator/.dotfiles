{ pkgs, ... }:

{
  # Originally this file was meant to be just for kde plasma but it has grown
  # to include other desktop environments, feel free to remove any you dont
  # want/need.

  #KDE plasma
  services.desktopManager.plasma6.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    oxygen
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
  ];

  #Gnome
  environment.pathsToLink = [ "/libexec" ];
  services.xserver.desktopManager.gnome.enable = true;

  #cinnamon
  services.xserver.desktopManager.cinnamon.enable = true;

  # Hastag #icantdecidewhatmyfavouriteDEis :)

}

