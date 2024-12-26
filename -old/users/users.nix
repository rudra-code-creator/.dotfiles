# users.nix
{
  # config,
  pkgs,
  # lib,
  ...
}:

{

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  users.users.root.shell = pkgs.bash;

  users.users = {
    rudra = {
      isNormalUser = true;
      useDefaultShell = true;
      extraGroups = [
        "rudra"
        "wheel"
        "cups"
        "networkmanager"
        "scanner"
        "lp"
        "libvirtd"
        "docker"
        "adbusers"
        "kvm"
      ];
      uid = 1000; # It's good practice to explicitly set the UID
      initialPassword = "abcde12345"; # Plain text password for testing BE SURE TO CHANGE IT
    };
    # Add Other Users
    #rudratwo = {
    #  isNormalUser = true;
    #  extraGroups = [ "rudratwo" "cups" "networkmanager" ];
    #  uid = 1001;  
    #};
  };

  users.groups = {
    rudra = {
      gid = 1000;
    };
    # You can define other groups here as needed
    #rudratwo = {
    #  gid = 1001;
    #};
  };
}

# Manuall set userid and groupid
#sudo usermod -u 1000 rudra
#sudo groupmod -g 1001 rudratwo
#sudo usermod -u 1000 rudra
#sudo groupmod -g 1001 rudratwo
