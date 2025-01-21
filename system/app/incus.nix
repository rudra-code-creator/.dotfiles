{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    incus
  ];

  virtualisation.incus = {
    enable = false;
    startTimeout = 6;

    package = pkgs.incus;
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
