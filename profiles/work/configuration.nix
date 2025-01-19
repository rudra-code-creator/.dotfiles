# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  lib,
  systemSettings,
  userSettings,
  ...
}: {
  imports = [
    ../../system/hardware-configuration.nix
    ../../system/hardware/systemd.nix # systemd config
    ../../system/hardware/kernel.nix # Kernel config
    ../../system/hardware/power.nix # Power management
    ../../system/hardware/time.nix # Network time sync
    ../../system/hardware/opengl.nix
    ../../system/hardware/printing.nix
    ../../system/hardware/samba.nix
    ../../system/hardware/bluetooth.nix

    # ../../system/app/custom-systemd-services.nix
    # ../../system/hardware/displaylink/displaylink.nix #Can't figure out how to get this working ARGGGGGH, will revisit if I ever get a laptop that uses displaylink
    (./. + "../../../system/wm" + ("/" + userSettings.wm) + ".nix") # My window manager
    #../../system/app/flatpak.nix

    ../../system/app/virtualization.nix
    ../../system/app/incus.nix
    (import ../../system/app/docker.nix {
      storageDriver = null;
      inherit pkgs userSettings lib;
    })

    ../../system/security/doas.nix
    ../../system/security/gpg.nix
    ../../system/security/blocklist.nix
    ../../system/security/firewall.nix
    ../../system/security/firejail.nix
    ../../system/security/openvpn.nix
    ../../system/security/automount.nix
    ../../system/style/stylix.nix
  ];

  # Fix nix path
  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=$HOME/.dotfiles/system/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];
  # Ensure nix flakes are enabled
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

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

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [(self: super: {utillinux = super.util-linux;})];

  #   nixpkgs.overlays = [
  #     (
  #       final: prev: {
  #         logseq = prev.logseq.overrideAttrs (oldAttrs: {
  #           postFixup = ''
  #             makeWrapper ${prev.electron_27}/bin/electron $out/bin/${oldAttrs.pname} \
  #               --set "LOCAL_GIT_DIRECTORY" ${prev.git} \
  #               --add-flags $out/share/${oldAttrs.pname}/resources/app \
  #               --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}" \
  #               --prefix LD_LIBRARY_PATH : "${prev.lib.makeLibraryPath [prev.stdenv.cc.cc.lib]}"
  #           '';
  #         });
  #       }
  #     )
  #   ];

  # logseq
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  # Enable bin files to run
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    #IMPORTANT:
    #put any missing dynamic libs for unpacking programs here,
    #NOT in environment.systemPackages
  ];

  nix = {
    settings = {
      trusted-users = ["@wheel" "root" "rudra"];
      allowed-users = ["@wheel" "root" "rudra"];

      experimental-features = "nix-command flakes";
      http-connections = 50;
      warn-dirty = false;
      log-lines = 50;

      sandbox = "relaxed";
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };
    #for nixD

    # flake-utils-plus
    # generateRegistryFromInputs = true;
    # generateNixPathFromInputs = true;
    # linkInputs = true;
  };

  # Kernel modules
  boot.kernelModules = ["i2c-dev" "i2c-piix4" "cpufreq_powersave" "fuse"];

  # Bootloader
  # Use systemd-boot if uefi, default to grub otherwise
  boot.loader.systemd-boot.enable =
    if (systemSettings.bootMode == "uefi")
    then true
    else false;
  boot.loader.efi.canTouchEfiVariables =
    if (systemSettings.bootMode == "uefi")
    then true
    else false;

  # boot.loader.efi.efiSysMountPoint = systemSettings.bootMountPath; # does nothing if running bios rather than uefi

  boot.loader.grub.enable =
    if (systemSettings.bootMode == "uefi")
    then false
    else true;
  boot.loader.grub.device = systemSettings.grubDevice; # does nothing if running uefi rather than bios

  # Networking
  networking.hostName = systemSettings.hostname; # Define your hostname.
  networking.networkmanager.enable = true; # Use networkmanager

  # Timezone and locale
  time.timeZone = systemSettings.timezone; # time zone
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  # User account
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = ["networkmanager" "wheel" "input" "dialout" "video" "render" "fuse"];
    packages = [];
    uid = 1000;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2E... machine_a_public_key"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5... machine_b_public_key"
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    logseq
    wget
    zsh
    git
    cryptsetup
    home-manager
    wpa_supplicant
    sshfs
    openssh
    fuse

    #NIX/NIXOS ecosystem
    nil
    nixfmt-rfc-style
    nix-index
    nix-prefetch-git
    nix-melt
    nix-ld
    nix-output-monitor
    nvd
    nvdtools
    nh # Nix helper

    flake-checker # Flake health checker
    autoflake #Tool to remove unused imports and unused variables
    deploy-rs
    fh

    # Basics:
    alacritty # terminal
    kitty
    wezterm
    chromium # browser
    xed-editor # text editor
    rofi # app launcher
    dmenu # launcher
    micro # terminal text editor
    neofetch
    git
    eza
    waynergy
    gnome-extension-manager

    licensor
    snowflake # system to beat internet censorship

    # Nix Utils
    nix-index
    #nix-init #TODO: figure out why this takes over an hour to compile
    nix-melt
    nix-update
    nixpkgs-fmt
    nixpkgs-hammering
    nixpkgs-review
    nurl
    nil # Nix LSP
    tokei

    # NIX CODE FORMATTERS
    nixfmt-rfc-style # my favourite - new official style for nixpkgs
    nixpkgs-fmt # ugly but current official style for nixpkgs
    alejandra # fast and reliable, readable style

    nixd # BETTER NIX LSP

    fish
    nushell

    #zsh
    zsh
    zsh-z
    zsh-bd
    zsh-edit

    # File Manager:
    xfce.thunar
    xfce.thunar-archive-plugin

    # Others:
    bash
    folder-color-switcher
    cups
    distrobox
    gpick
    haskellPackages.greenclip
    networkmanagerapplet
    pyload-ng
    trash-cli
    unzip
    vlc
    wget
    xarchiver
    xorg.xmodmap
    xorg.setxkbmap

    # Audio
    pulseaudio
    pamixer
    pavucontrol

    # Trackpad
    libinput
    libinput-gestures
    libnotify
    libimobiledevice
    ifuse

    # Script Dependencies
    coreutils
    ffmpeg_7
    findutils
    gawk
    moreutils
    perl
    rclone
    rename
    rsync
    jq
    nitch
    eza
    bat

    # for compiling
    gcc
    gnumake
    xorg.libxcb

    # Windows Manager
    xorg.xinit

    # xdm build
    jdk
    maven

    #KUBERNETES and kubectl, helm, minikube
    kubernix
    kubergrunt

    kubernetes
    kubernetes-code-generator
    kubernetes-controller-tools
    kubernetes-helm
    kubernetes-helm-wrapped

    #kubernetes-helmPlugins #UNPUBLISHED FROM NIXPKGS

    kubernetes-metrics-server
    kubernetes-polaris

    kubectl
    kubectl-cnpg
    kubectl-convert
    kubectl-df-pv
    kubectl-doctor
    kubectl-evict-pod
    kubectl-example
    kubectl-explore
    kubectl-gadget
    kubectl-images
    kubectl-klock
    kubectl-ktop
    kubectl-neat
    kubectl-node-shell
    kubectl-tree
    kubectl-validate
    kubectl-view-allocations
    kubectl-view-secret

    (import ../../system/bin/my-awesome-script.nix {inherit pkgs;})

    (pkgs.writeScriptBin "comma" ''
      if [ "$#" = 0 ]; then
        echo "usage: comma PKGNAME... [EXECUTABLE]";
      elif [ "$#" = 1 ]; then
        nix-shell -p $1 --run $1;
      elif [ "$#" = 2 ]; then
        nix-shell -p $1 --run $2;
      else
        echo "error: too many arguments";
        echo "usage: comma PKGNAME... [EXECUTABLE]";
      fi
    '')
  ];

  # I use zsh btw
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  fonts.fontDir.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # It is ok to leave this unchanged for compatibility purposes
  system.stateVersion = "22.11";

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
    pinentryPackage = pkgs.pinentry-curses;
  };

  services = {
    libinput.enable = true; # Enable touchpad support
    #TODO: play with tailscale
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
    flatpak.enable = true;
    usbmuxd.enable = true;
    mpd.enable = true; # Music Player Demon
    # Commented out services
    # prowlarr.enable = true;
    # sonarr.enable = true;
    # jellyfin.enable = true;
    # jackett.enable = true;
    # radarr.enable = true;
    deluge = {
      enable = true;
      # declarative = true;
    };

    openssh = {
      enable = true;

      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
        # Enable SFTP subsystem
        Subsystem = "sftp internal-sftp";
      };

      # Consider changing this if you need SSH access from other machines
      listenAddresses = [
        {
          addr = "127.0.0.1";
          port = 22;
        }
        {
          addr = "::1";
          port = 22;
        }
      ];
    };
  };

  environment.etc."ssh/ssh_config".text = ''
    Host remote
      HostName remote
      User rudra
      Port 22
      ForwardX11 yes
      IdentityFile ~/.ssh/id_ed25519
      ServerAliveInterval 60
      ServerAliveCountMax 3
      Compression yes
  '';

  systemd.services.NetworkManager-wait-online.enable = false;

  # XFCE desktop manager (for Thunar preferences)
  services.xserver.desktopManager.xfce = {
    enable = true;
  };

  # Enable X11 forwarding
  services.xserver.enable = true;

  # Allow users in the "fuse" group to use FUSE
  users.groups.fuse = {};

  #Enable Sudo [REPLACED BY DOAS]
  # security.sudo.enable = true;
  # security.sudo.wheelNeedsPassword = false;
}
