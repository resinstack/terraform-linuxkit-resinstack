locals {
  has_consul = (var.enable_consul || var.consul_server)
  consul_acl = (var.enable_consul || var.consul_server) && var.consul_default_deny
}

data "linuxkit_config" "build" {
  kernel = data.linuxkit_kernel.kernel.id
  init   = [data.linuxkit_init.init.id]

  onboot = [
    data.linuxkit_image.sysctl.id,
    data.linuxkit_image.rngd_boot.id,
    data.linuxkit_image.dhcp_boot.id,
    data.linuxkit_image.metadata.id,
  ]

  services = flatten([
    data.linuxkit_image.dhcp_svc.id,
    data.linuxkit_image.acpid.id,
    data.linuxkit_image.rngd_svc.id,
    var.enable_console ? [data.linuxkit_image.getty.id] : [],
    var.enable_sshd ? [data.linuxkit_image.sshd.id] : [],
    var.enable_consul ? [data.linuxkit_image.consul.id] : [],
  ])

  files = flatten([
    local.has_consul ? [data.linuxkit_file.consul_base.id] : [],
    var.consul_server ? [data.linuxkit_file.consul_server.id] : [],
    local.consul_acl ? [data.linuxkit_file.consul_acl.id] : [],
  ])
}

resource "linuxkit_build" "build" {
  config_yaml = data.linuxkit_config.build.yaml
  destination = "${local.output_base}.tar"
}
