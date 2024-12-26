{ config, pkgs, userSettings, ... }:

{
  programs.nnn = {
    enable = true;

    package = pkgs.nnn.override { withNerdIcons = true; };
    extraPackages = with pkgs; [ ffmpegthumbnailer mediainfo sxiv ];

    bookmarks = {
      d = "~/Documents";
      D = "~/Downloads";
      p = "~/Pictures";
      v = "~/Videos";
    };

    plugins.mappings = {
      c = "fzcd";
      f = "finder";
      v = "imgview";
    };

    plugins.src = (pkgs.fetchFromGitHub {
      owner = "jarun";
      repo = "nnn";
      rev = "v4.0";
      sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k=";
    }) + "/plugins";
  };
}
