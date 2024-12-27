{
  # config,
  pkgs,
  ...
}:

{
  hardware.opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-ocl
        vaapiIntel
      ];
    };

    programs.dzgui.enable = true;

    environment.systemPackages = [
      pkgs.prismlauncher
      pkgs.lutris
      pkgs.heroic
      pkgs.custom.olympus

      pkgs.gamemode
      pkgs.mangohud

      pkgs.gamescope

      pkgs.custom.relive

      pkgs.r2modman
    ];

    services.flatpak.packages = [
      "at.vintagestory.VintageStory"
      "com.usebottles.bottles"
    ];

}
