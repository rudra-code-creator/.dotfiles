{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    incus
  ];

  virtualisation.incus = {
    enable = true;
    package = pkgs.incus-lts;
    lxcPackage = config.virtualisation.lxc.package;
    clientPackage = config.virtualisation.incus.package.client;
    agent.enable = true;
    softDaemonRestart = true;

    ui = {
      enable = true;
      package = pkgs.incus.ui;
    };
  };
}
