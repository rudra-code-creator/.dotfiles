{pkgs, ...}: {
  programs.adb.enable = true;

  home.packages = with pkgs; [
    # Android
    android-tools
    android-udev-rules
  ];

  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
