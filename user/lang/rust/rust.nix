{pkgs, ...}: {
  home.packages = with pkgs; [
    cargo
    clang
    clippy
    mold
    rust-analyzer
    rustc
    rustfmt
    # rustup
    vscode-extensions.llvm-org.lldb-vscode # for hx
  ];

  home.file.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker = "clang"
    rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"]

    [registries.crates-io]
    protocol = "sparse"
  '';
}
