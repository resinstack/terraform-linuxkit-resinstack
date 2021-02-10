locals {
  has_consul = (var.enable_consul || var.consul_server)
  has_nomad  = (var.nomad_server || var.nomad_client)
}

data "linuxkit_config" "build" {
  kernel = data.linuxkit_kernel.kernel.id
  init   = [data.linuxkit_init.init.id]

  onboot = flatten([
    data.linuxkit_image.sysctl.id,
    data.linuxkit_image.rngd_boot.id,
    data.linuxkit_image.dhcp_boot.id,
    data.linuxkit_image.metadata.id,
    var.custom_onboot,
  ])

  services = flatten([
    data.linuxkit_image.acpid.id,
    data.linuxkit_image.dhcp_svc.id,
    data.linuxkit_image.rngd_svc.id,
    local.has_consul ? [data.linuxkit_image.coredns.id] : [],
    local.has_nomad ? [data.linuxkit_image.nomad.id] : [],
    var.enable_console ? [data.linuxkit_image.getty.id] : [],
    var.enable_consul ? [data.linuxkit_image.consul.id] : [],
    var.enable_docker ? [data.linuxkit_image.docker.id] : [],
    var.enable_emissary ? [data.linuxkit_image.emissary.id] : [],
    var.enable_ntpd ? [data.linuxkit_image.ntpd.id] : [],
    var.enable_sshd ? [data.linuxkit_image.sshd.id] : [],
    var.vault_server ? [data.linuxkit_image.vault.id] : [],
    var.custom_services,
  ])

  files = flatten([
    local.has_consul ? [data.linuxkit_file.consul_acl.id] : [],
    local.has_consul ? [data.linuxkit_file.consul_base.id] : [],
    local.has_consul ? [data.linuxkit_file.coredns_corefile.id] : [],
    local.has_consul ? [data.linuxkit_file.coredns_resolvconf.id] : [],
    local.has_nomad ? [data.linuxkit_file.nomad_base.id] : [],
    local.has_nomad ? [data.linuxkit_file.nomad_acl.id] : [],
    var.consul_server ? [data.linuxkit_file.consul_server.id] : [],
    var.enable_docker ? [data.linuxkit_file.docker_config.id] : [],
    var.enable_emissary ? [data.linuxkit_file.emissary_restart.id] : [],
    var.nomad_server ? [data.linuxkit_file.nomad_server.id] : [],
    var.nomad_client ? [data.linuxkit_file.nomad_client.id] : [],
    var.vault_server ? [data.linuxkit_file.vault_api_addr.id] : [],
    var.custom_files
  ])
}

resource "linuxkit_build" "build" {
  config_yaml = data.linuxkit_config.build.yaml
  destination = "${local.output_base}.tar"
}
