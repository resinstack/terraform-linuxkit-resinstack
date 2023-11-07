locals {
  has_consul = (var.enable_consul || var.consul_server)
  has_nomad  = (var.nomad_server || var.nomad_client)
}

data "linuxkit_config" "build" {
  kernel = data.linuxkit_kernel.kernel.id
  init = [
    data.linuxkit_init.init.id,
  ]

  onboot = flatten([
    data.linuxkit_image.sysctl.id,
    data.linuxkit_image.sysfs.id,
    data.linuxkit_image.rngd_boot.id,
    data.linuxkit_image.dhcp_boot.id,
    data.linuxkit_image.metadata.id,
    var.enable_persist ? [data.linuxkit_image.format.id] : [],
    var.enable_persist ? [data.linuxkit_image.mount.id] : [],
    var.custom_onboot,
  ])

  services = flatten([
    data.linuxkit_image.acpid.id,
    data.linuxkit_image.dhcp_svc.id,
    data.linuxkit_image.rngd_svc.id,
    data.linuxkit_image.logwrite.id,
    local.has_consul ? [data.linuxkit_image.coredns.id] : [],
    local.has_nomad ? [data.linuxkit_image.nomad.id] : [],
    var.enable_boundary ? [data.linuxkit_image.boundary.id] : [],
    var.vault_agent ? [data.linuxkit_image.vault_agent.id] : [],
    var.enable_console ? [data.linuxkit_image.getty.id] : [],
    var.enable_consul ? [data.linuxkit_image.consul.id] : [],
    var.enable_docker ? [data.linuxkit_image.docker.id] : [],
    var.enable_ntpd ? [data.linuxkit_image.ntpd.id] : [],
    var.enable_sshd ? [data.linuxkit_image.sshd.id] : [],
    var.enable_step ? [data.linuxkit_image.step.id] : [],
    var.vault_server ? [data.linuxkit_image.vault.id] : [],
    var.custom_services,
  ])

  files = flatten([
    data.linuxkit_file.containerd_toml.id,
    local.has_consul ? [data.linuxkit_file.consul_svc.id] : [],
    local.has_consul ? [data.linuxkit_file.consul_spr.id] : [],
    local.has_consul ? [data.linuxkit_file.consul_acl.id] : [],
    local.has_consul ? [data.linuxkit_file.consul_base.id] : [],
    local.has_consul ? [data.linuxkit_file.coredns_corefile.id] : [],
    local.has_consul ? [data.linuxkit_file.coredns_resolvconf.id] : [],
    local.has_nomad ? [data.linuxkit_file.nomad_svc.id] : [],
    local.has_nomad ? [data.linuxkit_file.nomad_spr.id] : [],
    local.has_nomad ? [data.linuxkit_file.nomad_base.id] : [],
    local.has_nomad ? [data.linuxkit_file.nomad_acl.id] : [],
    var.consul_server ? [data.linuxkit_file.consul_server.id] : [],
    var.enable_boundary ? [data.linuxkit_file.boundary_svc.id] : [],
    var.enable_boundary ? [data.linuxkit_file.boundary_spr.id] : [],
    var.enable_docker ? [data.linuxkit_file.docker_config.id] : [],
    var.enable_ntpd ? [data.linuxkit_file.ntpd_conf.id] : [],
    var.enable_step ? [data.linuxkit_file.step.id] : [],
    var.nomad_client ? [data.linuxkit_file.nomad_client.id] : [],
    var.nomad_server ? [data.linuxkit_file.nomad_server.id] : [],
    var.nomad_vault_integration && local.has_nomad ? [data.linuxkit_file.nomad_client_vault.id] : [],
    var.vault_server ? [data.linuxkit_file.vault_svc.id] : [],
    var.vault_server ? [data.linuxkit_file.vault_spr.id] : [],
    var.vault_server && var.vault_ui ? [data.linuxkit_file.vault_ui.id] : [],
    var.vault_server && var.enable_step ? [data.linuxkit_file.vault_cert_reload.id] : [],
    var.vault_agent ? [data.linuxkit_file.vault_agent_svc.id] : [],
    var.vault_agent ? [data.linuxkit_file.vault_agent_spr.id] : [],
    var.vault_agent && var.enable_step ? [data.linuxkit_file.vault_agent_cert_reload.id] : [],
    var.vault_agent ? [data.linuxkit_file.vault_agent_config.id] : [],
    var.vault_agent && local.has_consul ? [data.linuxkit_file.vault_agent_consul_tpl.id] : [],
    var.vault_agent && var.vault_server ? [data.linuxkit_file.vault_agent_server_tpl.id] : [],
    var.vault_agent && var.nomad_server ? [data.linuxkit_file.vault_agent_nomad_server_tpl.id] : [],
    var.vault_agent && var.nomad_client ? [data.linuxkit_file.vault_agent_nomad_client_tpl.id] : [],
    var.custom_files
  ])
}

resource "linuxkit_build" "build" {
  config_yaml         = data.linuxkit_config.build.yaml
  docker_cache_enable = true
  destination         = "${local.output_base}.tar"
}
