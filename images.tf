locals {
  output_base = "${var.output_to != "" ? var.output_to : path.root}/${var.base_name}"
}

resource "linuxkit_image_raw_bios" "raw_bios" {
  count = var.build_raw_bios ? 1 : 0

  build       = linuxkit_build.build.destination
  destination = "${local.output_base}_raw_bios.img"
}

resource "linuxkit_image_kernel_initrd" "kernel_initrd" {
  count = var.build_pxe ? 1 : 0

  build = linuxkit_build.build.destination
  destination = {
    cmdline = "${local.output_base}_cmdline"
    kernel  = "${local.output_base}_vmlinuz"
    initrd  = "${local.output_base}_initrd"
  }
}
