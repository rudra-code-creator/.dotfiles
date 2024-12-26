{
  # config,
  # pkgs,
  # callPackage,
  ...
}:

{
  environment.pathsToLink = [ "/libexec" ];
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
}
