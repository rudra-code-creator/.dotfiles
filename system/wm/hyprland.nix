{
  inputs,
  pkgs,
  ...
}: let
  pkgs-hyprland = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  # Import wayland config
  imports = [
    ./wayland.nix
    ./pipewire.nix
    ./dbus.nix
    ./hyprland/wlogout.nix
  ];

  # Security
  security = {
    pam.services.login.enableGnomeKeyring = true;
  };

  services.gnome.gnome-keyring.enable = true;

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland = {
        enable = true;
      };
      portalPackage = pkgs-hyprland.xdg-desktop-portal-hyprland;
    };
  };

  # services.xserver.excludePackages = [ pkgs.xterm ];

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.defaultSession = "plasmax11";
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      theme = "chili";
      # package = pkgs.sddm;
    };
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
  ];
}
