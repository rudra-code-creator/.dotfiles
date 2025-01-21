{pkgs, ...}: {
  imports = [
    ./pipewire.nix
    ./dbus.nix
    ./gnome-keyring.nix
    ./fonts.nix
    ./plasma.nix
  ];

  # Configure X11
  services.xserver = {
    enable = true;
    exportConfiguration = true;
    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:escape";
    excludePackages = [pkgs.xterm];

    # I can't live with the slow default key repeat delays:
    autoRepeatDelay = 200;
    autoRepeatInterval = 25;

    displayManager = {
      lightdm.enable = true;
      sessionCommands = ''
        xset -dpms
        xset s blank
        xset r rate 350 50
        xset s 300
        ${pkgs.lightlocker}/bin/light-locker --idle-hint &
      '';
    };
    libinput = {
      touchpad.disableWhileTyping = true;
    };
  };
}
