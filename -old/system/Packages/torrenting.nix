{
  # config,
  # pkgs,
  ...
}: {
  services.deluge = {
    enable = true;
    declarative = true;
  };
}
