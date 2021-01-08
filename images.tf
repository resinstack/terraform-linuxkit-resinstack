resource "linuxkit_image_raw_bios" "raw_bios" {
  build       = linuxkit_build.build.destination
  destination = "${path.root}/${var.base_name}_raw_bios.img"
}

resource "linuxkit_image_kernel_initrd" "kernel_initrd" {
  build = linuxkit_build.build.destination
  destination = {
    cmdline = "${path.root}/${var.base_name}_cmdline"
    kernel  = "${path.root}/${var.base_name}_vmlinuz"
    initrd  = "${path.root}/${var.base_name}_initrd"
  }
}
