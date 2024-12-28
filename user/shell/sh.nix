{
  pkgs,
  systemSettings,
  userSettings,
  ...
}: let
  # My shell aliases
  myAliases = {
    shopt = "setopt";
    ls = "eza --icons -l -T -L=1";
    htop = "btm";
    fd = "fd -Lu";
    w3m = "w3m -no-cookie -v";
    neofetch = "disfetch";
    fetch = "disfetch";
    gitfetch = "onefetch";
    "," = "comma";

    # Nixos commands
    rebuild = "sudo nixos-rebuild switch";
    cdmodules = "cd $HOME/nixos-config/modules";
    cdnix = "cd $HOME/nixos-config";
    config = "micro $HOME/nixos-config/configuration.nix";
    nixgarbage = "sudo nix-store --gc";

    # APP LAUNCH
    timeshift = "sudo timeshift-gtk";
    gparted = "sudo gparted";
    vmm = "virt-manager";
    gufw = "sudo gufw";
    ufw = "sudo ufw";

    # FILE LOCATIONS
    dow = "cd $HOME/Downloads";
    hom = "cd ~/";

    # QUICK TERMS
    ll = "eza --icons -l -T -L=1";
    cl = "clear";
    CL = "clear";
    xx = "find . -type f \\( -name \"*.sh\" -o -name \"*.py\" -o -name \"*.perl\"       -o -name \"*.AppImage\" \\) -exec chmod +x {} +";
    cron = "crontab -e";
    cronjob20 = "sudo journalctl -u cron -n 20";
    cronjob40 = "sudo journalctl -u cron -n 40";
    cronjob50 = "sudo journalctl -u cron -n 50";
    back = "cd ../";
    back2 = "cd ../..";
    back3 = "cd ../../..";
    mega = "mega-sync";
    makes = "makepkg -si";
    uninstall = "flatpak uninstall";
    samba = "sudo micro /etc/samba/smb.conf";
    dup = "sudo docker-compose up -d";
    pup = "sudo podman-compose up -d";
    source = "source ~/.bashrc";
    SOURCE = "source ~/.bashrc";
    trash = "trash-empty";
    w = "wget";
    ireload = "i3-msg reload";
    sreload = "swaymsg reload";
    scr = "bash $HOME/.scripts/scrcp.sh";
    apacherestart = "sudo systemctl restart apache2";

    sv = "sudo nvim";
    fr = "nh os switch --hostname ${systemSettings.hostname} /home/${userSettings.username}/flakes";
    fu = "nh os switch --hostname ${systemSettings.hostname} --update /home/${userSettings.username}/flakes";
    ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
    opts = "man home-configuration.nix";
    zed = "zeditor";
    lg = "lazygit";
    ip = "ip -color";
    tarnow = "tar -acf ";
    untar = "tar -zxvf ";
    egrep = "grep -E --color=auto";
    fgrep = "grep -F --color=auto";
    grep = "grep --color=auto";
    vdir = "vdir --color=auto";
    dir = "dir --color=auto";
    v = "nvim";
    cat = "bat --style snip --style changes --style header";
    l = "eza -lh --icons=auto"; # long list
    la = "eza -lah --icons --grid --group-directories-first --icons";
    ld = "eza -lhD --icons=auto";
    lt = "eza --icons=auto --tree"; # list folder as tree
    # Get the error messages from journalctl
    jctl = "journalctl -p 3 -xb";

    mkdir = "mkdir -p";
    yz = "yazi";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
  };
in {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "sudo"];
    };
    profileExtra = ''
      #if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #  exec Hyprland
      #fi
      setopt correct                                                  # Auto correct mistakes
      setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
      setopt nocaseglob                                               # Case insensitive globbing
      setopt rcexpandparam                                            # Array expension with parameters
      setopt nocheckjobs                                              # Don't warn about running processes when exiting
      setopt numericglobsort                                          # Sort filenames numerically when it makes sense
      setopt nobeep                                                   # No beep
      setopt appendhistory                                            # Immediately append history instead of overwriting
      setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
      setopt autocd                                                   # if only directory path is entered, cd there.
      setopt auto_pushd
      setopt pushd_ignore_dups
      setopt pushdminus
    '';
    initExtra = ''
      fastfetch
      if [ -f $HOME/.zshrc-personal ]; then
        source $HOME/.zshrc-personal
      fi
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
      export MANPAGER='nvim +Man!'
      export MCFLY_KEY_SCHEME=vim
      export MCFLY_FUZZY=2
      export MCFLY_RESULTS=50
      export MCFLY_RESULTS_SORT=LAST_RUN
      export MCFLY_INTERFACE_VIEW=BOTTOM
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  home.packages = with pkgs; [
    disfetch
    lolcat
    cowsay
    onefetch
    gnugrep
    gnused
    bat
    eza
    bottom
    fd
    bc
    direnv
    nix-direnv
  ];

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.enableBashIntegration = true;
  programs.direnv.nix-direnv.enable = true;
}
