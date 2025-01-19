{
  pkgs,
  lib,
  userSettings,
  storageDriver ? null,
  ...
}:
assert lib.asserts.assertOneOf "storageDriver" storageDriver [
  null
  "aufs"
  "btrfs"
  "devicemapper"
  "overlay"
  "overlay2"
  "zfs"
]; {
  # Useful for AI #TODO make this work
  # hardware.nvidia-container-toolkit.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    storageDriver = storageDriver;
    autoPrune.enable = true;
  };
  users.users.${userSettings.username}.extraGroups = ["docker"];
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    lazydocker
  ];
}
