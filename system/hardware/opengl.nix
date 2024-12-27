{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-ocl
      vaapiIntel
      rocmPackages.clr.icd
    ];
  };

  # programs.dzgui.enable = true;

  environment.systemPackages = with pkgs; [
    prismlauncher
    lutris
    heroic
    #custom.olympus
    gamemode
    mangohud
    gamescope
    #custom.relive
    r2modman
  ];

  #TODO: find a solution for declaritively managing flatpak

  # services.flatpak.packages = [
  #   "at.vintagestory.VintageStory"
  #   "com.usebottles.bottles"
  # ];
}
