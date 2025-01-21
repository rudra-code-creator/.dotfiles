{
  config,
  pkgs,
  pkgs-stable,
  # pkgs-kdenlive,
  userSettings,
  lib,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  nixpkgs.overlays = [(self: super: {utillinux = super.util-linux;})];

  dconf = {
    enable = true;

    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        add-username-to-top-panel.extensionUuid
        alphabetical-app-grid.extensionUuid
        appindicator.extensionUuid
        auto-move-windows.extensionUuid

        blur-my-shell.extensionUuid
        burn-my-windows.extensionUuid

        caffeine.extensionUuid
        clipboard-indicator.extensionUuid
        coverflow-alt-tab.extensionUuid

        dash-to-panel.extensionUuid
        desktop-icons-ng-ding.extensionUuid

        extension-list.extensionUuid
        forge.extensionUuid
        gsconnect.extensionUuid
        hibernate-status-button.extensionUuid

        ip-finder.extensionUuid
        just-perfection.extensionUuid
        lan-ip-address.extensionUuid
        lock-keys.extensionUuid
        logo-menu.extensionUuid

        media-controls.extensionUuid
        open-bar.extensionUuid
        places-status-indicator.extensionUuid
        removable-drive-menu.extensionUuid

        settingscenter.extensionUuid
        tweaks-in-system-menu.extensionUuid
        user-themes.extensionUuid

        vitals.extensionUuid
        workspace-indicator.extensionUuid

        applications-menu.extensionUuid
        native-window-placement.extensionUuid
      ];
    };

    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  programs.home-manager.enable = true;
  # home-manager.backupFileExtension = "backup";

  imports = [
    (./. + "../../../user/wm" + ("/" + userSettings.wm + "/" + userSettings.wm) + ".nix") # My window manager selected from flake
    ../../user/shell/sh.nix # My zsh and bash config
    ../../user/app/nushell/nushell.nix # My nushell config
    ../../user/app/terminal/ghostty.nix
    ../../user/app/zed/zed.nix

    ../../user/shell/cli-collection.nix # Useful CLI apps
    #../../user/app/doom-emacs/doom.nix # My doom emacs config

    # Change neovim configs by selecting a different config ID:
    # over here --------------o
    #                         |
    #                         v
    ../../user/app/nvim-config2/neovim.nix

    #../../user/app/emacsng # Me experimenting with emacsng and a vanilla config
    ../../user/app/ranger/ranger.nix # My ranger file manager config
    ../../user/app/git/git.nix # My git config
    ../../user/app/bat/bat.nix # My bat config
    ../../user/app/manual/manual.nix # My manpages config
    ../../user/app/keepass/keepass.nix # My password manager
    (./. + "../../../user/app/browser" + ("/" + userSettings.browser) + ".nix") # My default browser selected from flake
    ../../user/app/virtualization/virtualization.nix # Virtual machines
    #../../user/app/flatpak/flatpak.nix # Flatpaks
    ../../user/style/stylix.nix # Styling and themes for my apps
    ../../user/lang/cc/cc.nix # C and C++ tools
    ../../user/lang/godot/godot.nix # Game development
    #../../user/pkgs/blockbench.nix # Blockbench ## marked as insecure
    ../../user/hardware/bluetooth.nix # Bluetooth
  ];

  home.file = {
    # To test whether home manager works
    "foo.txt".text = "bar";

    ".icons/bibata".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
    "Wallpapers".source = /home/rudra/.dotfiles/profiles/work/Wallpapers;

    # ".zshrc".source = ./dotfiles/zshrc/.zshrc;
    # ".config/wezterm".source = ./dotfiles/wezterm;
    ".config/starship".source = /home/rudra/.dotfiles/profiles/work/dotfiles/starship;
    ".config/zellij".source = /home/rudra/.dotfiles/profiles/work/dotfiles/zellij;
    # ".config/nvim".source = ./dotfiles/nvim;
    # ".config/gh".source = ./dotfiles/gh;

    # ".config/nushell/config.nu".source = ./dotfiles/nushell/config.nu;
    # ".config/nushell/env.nu".source = ./dotfiles/nushell/env.nu;

    # ".config/nix".source = ./dotfiles/nix;
    # ".config/nix-darwin".source = ./dotfiles/nix-darwin;
    ".config/tmux".source = /home/rudra/.dotfiles/profiles/work/dotfiles/tmux;
    # ".config/ghostty".source = /home/rudra/.dotfiles/profiles/work/dotfiles/ghostty;
  };

  home.stateVersion = "22.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # Core
    zsh
    alacritty
    brave
    # vivaldi
    # vivaldi-ffmpeg-codecs
    qutebrowser
    git
    syncthing

    vscode
    code-cursor
    vscode-runner
    vscode-js-debug
    vscode-langservers-extracted
    openvscode-server
    nvrh
    htop
    tmux

    metasploit
    yakuake

    # Office
    nextcloud-client
    libreoffice-fresh
    mate.atril
    openboard
    xournalpp
    adwaita-icon-theme
    shared-mime-info
    glib
    newsflash
    foliate
    nautilus
    gnome-calendar
    seahorse
    gnome-maps
    openvpn
    protonmail-bridge
    texliveSmall
    numbat
    element-desktop-wayland
    juno-theme
    openai-whisper-cpp
    dockerfile-language-server-nodejs

    # Testing
    kmonad # keybaord

    sassc
    gtk-engine-murrine
    gnome-themes-extra

    # Web Browsers:
    brave
    firefox
    microsoft-edge
    opera
    # vivaldi
    kdenlive

    # File Managers & Addons:
    xfce.catfish
    mate.caja-with-extensions
    ranger
    fzf

    # Music:
    clementine
    sayonara

    # Basics
    terminator # Konsole
    warp-terminal
    bitwarden # PW Manager
    wezterm
    tmux
    zellij
    cowsay
    fortune

    # Productivity:
    autokey
    flameshot
    fsearch
    gpick # Colorpicker x11
    eyedropper
    piper-tts
    scrcpy # Screen Record
    tree # directory structure hierarchies
    joplin-desktop # Notes
    bazecor
    github-desktop
    waynergy

    # Self Hosting:
    docker-compose
    cloudflared

    rustdesk
    rustdesk-server

    # Programming:
    android-tools
    dockerfile-language-server-nodejs
    #melos #A tool for managing Dart projects with multiple packages. With IntelliJ and Vscode IDE support. Supports automated versioning, changelogs & publishing via Conventional Commits.
    #neovim-unwrapped

    # vscodium # Text Editor
    vscode
    vscode-runner
    vscode-js-debug
    vscode-langservers-extracted
    code-cursor
    openvscode-server

    ghz # gRPC benchmarking and load testing
    ghc # Glasgow Haskell compiler
    # ghdl # VHDL 2008/93/87 simulator
    ghdl-llvm # VHDL 2008/93/87 simulator
    ghcid # GHCi based bare bones IDE
    ghciwatch # Ghci-based file watching recompiler for Haskell development
    gh-ost # Triggerless online schema migration solution for MySQL
    ghosttohugo
    ghostscript

    ghunt
    ghost
    ghostunnel
    ghidra
    ghauri

    #github
    gh
    ghr
    ghq
    ghorg
    gh-poi
    gh2md
    ghfetch
    ghp-import
    ghdorker
    ghrepo-stats
    ghostie # Github notifications

    #shell
    zoxide
    carapace
    atuin
    #nushell

    # Editing:
    gimp-with-plugins
    obs-studio

    # Virtual:
    distrobox
    virt-manager

    # TUI:
    bottom
    # cava
    cmatrix
    fastfetch
    figlet # ASVII Generator
    glava
    glow
    neofetch
    hello

    # Other
    ferdium
    gparted
    gthumb # Pic Viewer
    gtk4
    jumpapp
    localsend
    lsof
    megacmd
    playerctl
    polybarFull
    protonvpn-gui
    scrot # Screenshot
    starship
    syncthing
    tmux
    wine
    xarchiver
    xclip
    xdotool
    xvfb-run
    yt-dlp
    zenity # Prompt for new Files

    # fonts
    font-awesome
    nerdfonts
    unifont

    # Soulseek
    nicotine-plus
    slskd

    # Messaging
    discord
    telegram-desktop

    #JETBRAINS
    jetbrains-mono
    jetbrains-toolbox

    jetbrains.writerside
    jetbrains.webstorm
    jetbrains.rust-rover
    jetbrains.ruby-mine
    jetbrains.rider

    jetbrains.pycharm-professional
    jetbrains.pycharm-community-bin
    jetbrains.phpstorm

    jetbrains.mps
    jetbrains.jdk
    jetbrains.jcef

    jetbrains.idea-ultimate
    jetbrains.idea-community-bin

    jetbrains.goland
    jetbrains.gateway
    jetbrains.dataspell
    jetbrains.datagrip
    jetbrains.clion
    jetbrains.aqua

    #Kotlin
    kotlin
    kotlin-interactive-shell
    kotlin-language-server
    kotlin-native

    # Jellyfin Programs
    #jellyfin
    #jellyfin-ffmpeg
    #jellyfin-web

    wine
    bottles
    # The following requires 64-bit FL Studio (FL64) to be installed to a bottle
    # With a bottle name of "FL Studio"
    (pkgs.writeShellScriptBin "flstudio" ''
      #!/bin/sh
      if [ -z "$1" ]
        then
          bottles-cli run -b "FL Studio" -p FL64
          #flatpak run --command=bottles-cli com.usebottles.bottles run -b FL\ Studio -p FL64
        else
          filepath=$(winepath --windows "$1")
          echo \'"$filepath"\'
          bottles-cli run -b "FL Studio" -p "FL64" --args \'"$filepath"\'
          #flatpak run --command=bottles-cli com.usebottles.bottles run -b FL\ Studio -p FL64 -args "$filepath"
        fi
    '')
    (pkgs.makeDesktopItem {
      name = "flstudio";
      desktopName = "FL Studio 64";
      exec = "flstudio %U";
      terminal = false;
      type = "Application";
      icon = "flstudio";
      mimeTypes = ["application/octet-stream"];
    })
    (stdenv.mkDerivation {
      name = "flstudio-icon";
      # icon from https://www.reddit.com/r/MacOS/comments/jtmp7z/i_made_icons_for_discord_spotify_and_fl_studio_in/
      src = [../../user/pkgs/flstudio.png];

      unpackPhase = ''
        for srcFile in $src; do
          # Copy file into build dir
          cp $srcFile ./
        done
      '';

      installPhase = ''
        mkdir -p $out $out/share $out/share/pixmaps
        ls $src
        ls
        cp $src $out/share/pixmaps/flstudio.png
      '';
    })

    # Media
    krita
    pinta
    inkscape
    (pkgs-stable.lollypop.override {youtubeSupport = false;})
    vlc
    mpv
    yt-dlp
    blender-hip
    libresprite
    (pkgs.appimageTools.wrapType2 {
      name = "Cura";
      src = fetchurl {
        url = "https://github.com/Ultimaker/Cura/releases/download/5.8.1/UltiMaker-Cura-5.8.1-linux-X64.AppImage";
        hash = "sha256-VLd+V00LhRZYplZbKkEp4DXsqAhA9WLQhF933QAZRX0=";
      };
      # extraPkgs = pkgs: with pkgs; [];
    })
    #(pkgs-stable.cura.overrideAttrs (oldAttrs: {
    #  postInstall = oldAttrs.postInstall + ''cp -rf ${(pkgs.makeDesktopItem {
    #      name = "com.ultimaker.cura";
    #      icon = "cura-icon";
    #      desktopName = "Cura";
    #      exec = "env QT_QPA_PLATFORM=xcb ${pkgs-stable.cura}/bin/cura %F";
    #      tryExec = "env QT_QPA_PLATFORM=xcb ${pkgs-stable.cura}/bin/cura";
    #      terminal = false;
    #      type = "Application";
    #      categories = ["Graphics"];
    #      mimeTypes = ["model/stl" "application/vnd.ms-3mfdocument" "application/prs.wavefront-obj"
    #                   "image/bmp" "image/gif" "image/jpeg" "image/png" "text/x-gcode" "application/x-amf"
    #                   "application/x-ply" "application/x-ctm" "model/vnd.collada+xml" "model/gltf-binary"
    #                   "model/gltf+json" "model/vnd.collada+xml+zip"];
    #      })}/share/applications $out/share'';
    #}))
    #(pkgs.writeShellScriptBin "curax" ''env QT_QPA_PLATFORM=xcb ${pkgs-stable.cura}/bin/cura $@'')
    (pkgs-stable.curaengine_stable)
    openscad
    (stdenv.mkDerivation {
      name = "cura-slicer";
      version = "0.0.7";
      src = fetchFromGitHub {
        owner = "Spiritdude";
        repo = "Cura-CLI-Wrapper";
        rev = "ff076db33cfefb770e1824461a6336288f9459c7";
        sha256 = "sha256-BkvdlqUqoTYEJpCCT3Utq+ZBU7g45JZFJjGhFEXPXi4=";
      };
      phases = "installPhase";
      installPhase = ''
        mkdir -p $out $out/bin $out/share $out/share/cura-slicer
        cp $src/cura-slicer $out/bin
        cp $src/settings/fdmprinter.def.json $out/share/cura-slicer
        cp $src/settings/base.ini $out/share/cura-slicer
        sed -i 's+#!/usr/bin/perl+#! /usr/bin/env nix-shell\n#! nix-shell -i perl -p perl538 perl538Packages.JSON+g' $out/bin/cura-slicer
        sed -i 's+/usr/share+/home/${userSettings.username}/.nix-profile/share+g' $out/bin/cura-slicer
      '';
      propagatedBuildInputs = with pkgs-stable; [
        curaengine_stable
      ];
    })
    obs-studio
    ffmpeg
    (pkgs.writeScriptBin "kdenlive-accel" ''
      #!/bin/sh
      DRI_PRIME=0 kdenlive "$1"
    '')
    movit
    mediainfo
    libmediainfo
    audio-recorder
    cheese
    ardour
    rosegarden
    tenacity

    # Various dev packages
    remmina
    sshfs
    texinfo
    libffi
    zlib
    nodePackages.ungit
    ventoy
    kdenlive
  ];

  home.sessionPath = [
    # no need for a bare $PATH item; these are all appended to any base
    # PATH you already have
    # and /usr/bin isn't a thing on NixOS (all it should ever contain is
    # `env`, as a concession to shell scripts that haven't been fixup-ed
    # by a Nix derivation)
    "$HOME/.local/bin"
    "$HOME/rudra-app-repo"
  ];

  home.file.".local/share/pixmaps/nixos-snowflake-stylix.svg".source = config.lib.stylix.colors {
    template = builtins.readFile ../../user/pkgs/nixos-snowflake-stylix.svg.mustache;
    extension = "svg";
  };

  services.syncthing.enable = true;
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    templates = "${config.home.homeDirectory}/Templates";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
      XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
      XDG_VM_DIR = "${config.home.homeDirectory}/Machines";
      XDG_ORG_DIR = "${config.home.homeDirectory}/Org";
      XDG_PODCAST_DIR = "${config.home.homeDirectory}/Media/Podcasts";
      XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.associations.added = {
    # TODO fix mime associations, most of them are totally broken :(
    "application/octet-stream" = "flstudio.desktop;";
  };

  home.sessionVariables = {
    EDITOR = lib.mkDefault userSettings.editor;
    SPAWNEDITOR = userSettings.spawnEditor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };

  # Set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 22;
    # "Xft.dpi" = 172;
  };

  news.display = "silent";

  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name =
      if (config.stylix.polarity == "dark")
      then "Papirus-Dark"
      else "Papirus-Light";
  };

  services.pasystray.enable = true;
}
