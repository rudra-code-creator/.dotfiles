{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    virt-manager
    distrobox
    libvirt
    vmware-workstation
    vmware-horizon-client
  ];

  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    extraOptions = ["--verbose"];

    enable = true;
    package = pkgs.libvirt;
    nss.enableGuest = true;

    qemu.package = pkgs.qemu;
    qemu.runAsRoot = true;
    qemu.swtpm.enable = true; # Allows libvirtd to use swtpm to create an emulated TPM.
    qemu.swtpm.package = pkgs.swtpm;
    qemu.ovmf.enable = true; # Allows libvirtd to use OVMF to create an emulated UEFI firmware. # Allows libvirtd to take advantage of OVMF when creating new QEMU VMs with UEFI boot.
    qemu.ovmf.packages = [pkgs.OVMFFull.fd pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd];
    qemu.vhostUserPackages = [pkgs.virtiofsd];
  };

  programs.virt-manager.enable = true;
  virtualisation.waydroid.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # virtualisation.tpm.enable = true;
  # virtualisation.tpm.package = pkgs.swtpm;

  # Whether to enable KVMGT (iGVT-g) VGPU support.
  # Allows Qemu/KVM guests to share host’s Intel integrated graphics card.
  # Currently only one graphical device can be shared.
  # To allow users to access the device without root add them to the kvm group: users.extraUsers.<yourusername>.extraGroups = [ "kvm" ]; .
  virtualisation.kvmgt.enable = true;

  # vmware-vmx will cause kcompactd0 due to Transparent Hugepages feature in kernel. Apply [ "transparent_hugepage=never" ] in option boot.kernelParams to disable them.
  # If that didn’t work disable TRANSPARENT_HUGEPAGE, COMPACTION configs and recompile kernel.
  # see: https://search.nixos.org/options?channel=24.11&show=virtualisation.vmware.host.enable&from=50&size=50&sort=relevance&type=packages&query=.
  # boot.kernelParams = ["transparent_hugepage=never"];

  # Virtualbox is better
  # virtualisation.vmware = {
  #   host.enable = true;
  #   host.package = pkgs.vmware-workstation;
  #   host.extraPackages = [pkgs.ntfs3g];
  #   host.extraConfig = ''
  #     # Allow unsupported devices to use OpenGL and Vulkan acceleration for guest vGPU
  #     mks.gl.allowUnsupportedDrivers = "TRUE"
  #     mks.vk.allowUnsupportedDevices = "TRUE"
  #   '';

  #   guest.enable = true;
  # };

  virtualisation.virtualbox = {
    host.enable = true;
    host.package = pkgs.virtualbox;
    host.enableWebService = true;
    host.enableHardening = true;
    host.enableExtensionPack = true;

    guest.enable = true;
    # guest.verbose = false;
    # guest.vboxsf = true; # vboxsf is deprecated and not maintained.
    guest.seamless = true; # SO COOL: When activated windows from the guest appear next to the windows of the host.
    guest.dragAndDrop = true;
    guest.clipboard = true;

    #NOTE YOU CAN ONLY USE ONE OF THESE TWO OPTIONS AS THEY CONFLICT WITH EACH OTHER
    # host.enableKvm = true; # Note: This is experimental. Please check https://github.com/cyberus-technology/virtualbox-kvm/issues.
    host.addNetworkInterface = true; # Automatically set up a vboxnet0 host-only network interface.
  };

  #xen is pretty much a dead project these days, as qemu has adopted most of its features/advantages
  # virtualisation.xen.enable = true;
  # virtualisation.xen.trace = true;
  # virtualisation.xen.package = pkgs.xen;
  # virtualisation.xen.qemu.package = pkgs.qemu_xen;
  # virtualisation.xen.store.settings.enableMerge = true;
  # virtualisation.xen.efi.bootBuilderVerbosity = "info";
}
