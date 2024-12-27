{pkgs, ...}: let
  # My shell aliases
  myAliases = {
    shopt = "echo 'hello'";
    ls = "eza --icons -l -T -L=1";
    cat = "bat";
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
  };
in {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
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
