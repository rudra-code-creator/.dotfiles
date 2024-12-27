# Edit this configuration file to define what should be installed on your system.  Help is available in the
# configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{
  # config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    #../displaylink/displaylink.nix

    # System Settings
    ./audio.nix
    ./cron.nix
    ./cups.nix
    ./firewall.nix
    ./samba.nix
    ./services.nix
    ./ssh.nix
    ../users/users.nix
    ./virtualization.nix
    ./xdomap.nix
    ./android.nix

    #PACKAGES
    ./Packages/packages.nix
    # ./Packages/gnome-extensions.nix
  ];

  services.xserver = {
    enable = true;
  };

  # Define your hostname.
  networking.hostName = "nixos";

  # Define your nixos version.
  system.stateVersion = "24.05";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable UID and GUID change
  users.mutableUsers = true;

  environment = {
    sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_BIN_HOME = "$HOME/.local/bin";
      XDG_DESKTOP_DIR = "$HOME/Desktop";
    };

    variables = {
      # Make some programs "XDG" compliant.
      LESSHISTFILE = "$XDG_CACHE_HOME/less.history";
      WGETRC = "$XDG_CONFIG_HOME/wgetrc";
      XDG_TERMINAL = "alacritty";
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };

    shellAliases = {
      ".." = "cd ..";
      neofetch = "nitch";
      ls = "eza -la --icons --no-user --no-time --git -s type";
      cat = "bat";
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    (nerdfonts.override {fonts = ["JetBrainsMono"];})

    dejavu_fonts
    fira
    fira-code
    iosevka
  ];

  fonts.fontconfig = {
    defaultFonts.monospace = ["JetBrainsMono"];
    hinting.enable = false;
    subpixel.lcdfilter = "light"; # fix for status bar characters
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  #Enable Sudo

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 30;
  boot.loader.efi.canTouchEfiVariables = true;

  # Bootloader. (Use this for grub instead especially if you're on a VM)
  #boot.loader.grub.enable = true;
  #boot.loader.grub.device = "/dev/vda";
  #boot.loader.grub.useOSProber = true;

  # Swapfile
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  # garbage collection
  nix.gc.automatic = true;

  # Enable bin files to run
  programs.nix-ld.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  environment.sessionVariables = {
    PATH = ["${pkgs.pyload-ng}/bin"];
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
