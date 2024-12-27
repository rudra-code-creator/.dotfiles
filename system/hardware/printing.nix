{pkgs, ...}: {
  # Enable printing

  environment.systemPackages = with pkgs; [
    cups-filters
    gutenprint
    ghostscript
    foomatic-filters
    cups-pk-helper # For PolicyKit integration
    system-config-printer # GUI tool for printer management
  ];

  # Open necessary ports for network printing (already defined in firewall.nix)
  # networking.firewall = {
  #   enable = true;
  #   allowedTCPPorts = [ 631 9100 ];
  #   allowedUDPPorts = [ 631 5353 ];
  # };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };

  services.printing = {
    enable = true;
    browsing = true;
    defaultShared = true;
    drivers = [pkgs.canon-cups-ufr2];
    logLevel = "debug2";
    browsedConf = ''
      BrowseDNSSDSubTypes _cups,_print
      BrowseLocalProtocols all
      BrowseRemoteProtocols all
      CreateIPPPrinterQueues All
    '';
  };
}
