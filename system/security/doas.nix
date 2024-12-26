{ userSettings, pkgs, ... }:

{
  # Doas instead of sudo
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [

    {
      users = [ "${userSettings.username}" ];
      keepEnv = true;
      persist = true;
    }

    {
      users = [ "${userSettings.username}" ];
      cmd = "tee";
      noPass = true;
    }
  ];

  environment.systemPackages = [
    (pkgs.writeScriptBin "sudo" ''exec doas "$@"'')
  ];

  # Add an alias to the shell for backward-compat and convenience.
  # environment.shellAliases = {sudo = "doas";};

  # HACK: UNCOMMENT BELOW TO TURN ON LOCKDOWN MODE

  # # Ripped from:
  # # https://xeiaso.net/blog/paranoid-nixos-2021-07-18/

  # nix.allowedUsers = ["@wheel"];
  # environment.defaultPackages = lib.mkForce []; # Heres a great little piece, it disables any non defined packages for this system

  # services.openssh = {
  #   passwordAuthentication = false;
  #   allowSFTP = false; # Don't set this if you need sftp
  #   challengeResponseAuthentication = false;
  #   extraConfig = ''
  #     AllowTcpForwarding yes
  #     X11Forwarding no
  #     AllowAgentForwarding no
  #     AllowStreamLocalForwarding no
  #     AuthenticationMethods publickey
  #   '';
  # };

  # fileSystems."/".options = ["noexec"];
  # fileSystems."/etc/nixos".options = ["noexec"];
  # fileSystems."/srv".options = ["noexec"];
  # fileSystems."/var/log".options = ["noexec"];

  # environment.systemPackages = with pkgs; [clamav]; # PCI Compliance

  # HACK: UNCOMMENT ABOVE TO TURN ON LOCKDOWN MODE

}
