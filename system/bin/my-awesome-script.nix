{pkgs}:
pkgs.writeShellScriptBin "my-awesome-script" ''

  echo "hello world" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat

''
