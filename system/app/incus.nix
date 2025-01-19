{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    incus
  ];

  virtualisation.incus = {
    enable = true;

    ui = {
      enable = true;
      package = pkgs.incus.ui;
    };
  };
}
