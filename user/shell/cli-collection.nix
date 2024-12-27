{pkgs, ...}: {
  # Collection of useful CLI apps
  home.packages = with pkgs; [
    # Command Line
    disfetch
    lolcat
    cowsay
    starfetch
    cava
    killall
    libnotify
    timer
    brightnessctl
    gnugrep
    bat
    eza
    fd
    bottom
    ripgrep
    rsync
    unzip
    w3m
    pandoc
    hwinfo
    pciutils
    numbat
    vim
    neovim

    (pkgs.callPackage ../pkgs/pokemon-colorscripts.nix {})
    (pkgs.writeShellScriptBin "airplane-mode" ''
      #!/bin/sh
      connectivity="$(nmcli n connectivity)"
      if [ "$connectivity" == "full" ]
      then
          nmcli n off
      else
          nmcli n on
      fi
    '')
  ];

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
    tmux.shellIntegrationOptions = ["-d 40%"];
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
    # enableFishIntegration = true; #NIX COMPILER DOES NOT LIKE FOR SOME REASON
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
}
