{ 
  # config, 
  pkgs,
  ... 
}:

{

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    # Opengl
    graphics.enable = true;
    # Most wayland compositors need this
    nvidia.modesetting.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  environment.systemPackages = with pkgs; [
    cliphist
    hyprpaper
    hyprpicker
    hyprlock
    nwg-displays # wayland monitors
    nwg-look # wayland themes
    rofi-wayland
    waybar
    wlr-randr
    wtype
    wl-clipboard
    wpaperd
    dunst
    libnotify
    swww
    networkmanagerapplet
    wofi

    (pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
  ];
}
