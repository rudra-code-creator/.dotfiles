{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../rudra/home-packages.nix
    ../rudra/nushell.nix
    ../rudra/rust.nix
    # ../firefox.nix
    inputs.nix-colors.homeManagerModules.default

  ];

  home.username = "rudra";
  home.homeDirectory = "/home/rudra";

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



  qt.enable = true;
  qt.platformTheme.name = "gtk";

  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;

  gtk = {
    enable = true;

    cursorTheme.name = "Bibata-Modern-Ice";
    cursorTheme.package = pkgs.bibata-cursors;

    theme = {
      name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "macchiato";
      };
    };
  };
  # gtk.theme.name = "adw-gtk3";
  # gtk.theme.package = pkgs.adw-gtk3;

  # gtk.iconTheme.name = "GruvboxPlus";
  # gtk.iconTheme.package = gruvboxPlus;

  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  home.file = {
    # To test whether home manager works
    "foo.txt".text = "bar";

    ".icons/bibata".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
    "Wallpapers".source = ./Wallpapers;

    # ".zshrc".source = ./dotfiles-rudra/zshrc/.zshrc;
    # ".config/wezterm".source = ./dotfiles-rudra/wezterm;
    ".config/starship".source = ./dotfiles-rudra/starship;
    ".config/zellij".source = ./dotfiles-rudra/zellij;
    ".config/nvim".source = ./dotfiles-rudra/nvim;
    # ".config/gh".source = ./dotfiles-rudra/gh;

    # ".config/nushell/config.nu".source = ./dotfiles-rudra/nushell/config.nu;
    # ".config/nushell/env.nu".source = ./dotfiles-rudra/nushell/env.nu;

    # ".config/nix".source = ./dotfiles-rudra/nix;
    # ".config/nix-darwin".source = ./dotfiles-rudra/nix-darwin;
    ".config/tmux".source = ./dotfiles-rudra/tmux;
    ".config/ghostty".source = ./dotfiles-rudra/ghostty;
  };

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Set environment variables
  home.sessionVariables = {
    EDITOR = "micro";
    # PATH = "$PATH:/usr/bin:$HOME/.local/bin:$HOME/rudra-app-repo/";
  };

  home.sessionPath = [
    # no need for a bare $PATH item; these are all appended to any base
    # PATH you already have
    # and /usr/bin isn't a thing on NixOS (all it should ever contain is
    # `env`, as a concession to shell scripts that haven't been fixup-ed
    # by a Nix derivation)
    "$HOME/.local/bin"
    "$HOME/rudra-app-repo"
  ];

  # Set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 22;
    # "Xft.dpi" = 172;
  };

  # basic configuration of programs, please change to your own:
  #Git
  programs.bat = {
    enable = true;
    config = {
      theme = "github";
      italic-text = "always";
    };
  };

  # manual = {
  #   # Description
  #   # Whether to install the HTML manual. This also installs the
  #   # {command}home-manager-help tool, which opens a local
  #   # copy of the Home Manager manual in the system web browser.
  #   html.enable = true;
  #   # Description
  #   # Whether to install a JSON formatted list of all Home Manager
  #   # options. This can be located at
  #   # {file}/share/doc/home-manager/options.json,
  #   # and may be used for navigating definitions, auto-completing,
  #   # and other miscellaneous tasks.
  #   json.enable = true;
  #   # Description
  #   # Whether to install the configuration manual page. The manual can
  #   # be reached by {command}man home-configuration.nix.

  #   # When looking at the manual page pretend that all references to
  #   # NixOS stuff are actually references to Home Manager stuff.
  #   # Thanks!
  #   manpages.enable = true;
  # };

  programs.man = {
    enable = true;
    package = pkgs.man;
    generateCaches = true;
  };

  programs.nnn = {
    enable = true;

    package = pkgs.nnn.override { withNerdIcons = true; };
    extraPackages = with pkgs; [ ffmpegthumbnailer mediainfo sxiv ];

    bookmarks = {
      d = "~/Documents";
      D = "~/Downloads";
      p = "~/Pictures";
      v = "~/Videos";
    };

    plugins.mappings = {
      c = "fzcd";
      f = "finder";
      v = "imgview";
    };

    plugins.src = (pkgs.fetchFromGitHub {
      owner = "jarun";
      repo = "nnn";
      rev = "v4.0";
      sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k=";
    }) + "/plugins";
  };



  programs.git = {
    enable = true;
    userName = "rudra-code-creator";
    userEmail = "rudrakeshwani2@gmail.com";
  };

  programs.gh = {
    enable = true;
    settings = {
      version = "1";
      aliases = {
        "as" = "auth status";
        "al" = "auth login";
      };
      gitCredentialHelper.enable = true;
      extensions = with pkgs; [
        gh-dash
        gh-notify
        gh-copilot
        gh-screensaver
        gh-actions-cache
        gh-markdown-preview
        gh-eco
        gh-cal
        gh-s
        gh-f
      ];
    };
  };

  programs.fzf = {
    enable = true;
    package = pkgs.fzf;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    defaultOptions = [
      "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8"
      "--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc"
      "--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
      "--color=selected-bg:#45475a"
      "--multi"
    ];

    tmux.enableShellIntegration = true;
    tmux.shellIntegrationOptions = [ "-d 40%" ];

  };

  programs.bottom = {
    package = pkgs.bottom;
    enable = true;

    settings.flags = {
      battery = true;
      regex = true;
      avg_cpu = true;
      temperature_type = "c";
    };

    settings.colors = {
      low_battery_color = "red";
    };
  };

  programs.jq.enable = true;

  programs.mcfly = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    fuzzySearchFactor = 4;
    fzf.enable = true;
    interfaceView = "TOP";
    keyScheme = "vim";
  };

  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.nushell.enable = true;

  programs.carapace = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableIonIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.broot = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    # enableFishIntegration = true; #NIX COMPILER DOES NOOT LIKE FOR SOME REASON
    enableNushellIntegration = true;
    nix-direnv.enable = true;

    package = pkgs.direnv;
    nix-direnv.package = pkgs.nix-direnv;
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableIonIntegration = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  #TODO: Investigate keychain. looks like interesting tool
  programs.keychain = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableXsessionIntegration = true;

  };

  programs.thefuck = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  services.gpg-agent = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableExtraSocket = true;
    enableScDaemon = true;
  };

  # This value determines the home Manager release that yours
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  # home.enableNixpkgsReleaseCheck = false;
}
