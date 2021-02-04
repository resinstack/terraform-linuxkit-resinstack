data "linuxkit_image" "nomad" {
  name  = "nomad"
  image = "ghcr.io/resinstack/nomad:${var.nomad_version}"

  command = [
    "/nomad", "agent",
    "-config", "/etc/nomad",
    "-config", "/var/run/config/nomad"
  ]

  capabilities = [
    "CAP_CHOWN",
    "CAP_NET_ADMIN",
    "CAP_SYS_ADMIN",
  ]

  binds = [
    "/etc/nomad:/etc/nomad",
    "/etc/resolv.cluster:/etc/resolv.conf",
    "/lib/modules:/lib/modules",
    "/run:/run:shared",
    "/var/persist:/var/persist:rshared",
  ]

  rootfs_propagation = "shared"

  runtime {
    mkdir = [
      "/var/persist/nomad",
      "/var/run/config/nomad",
    ]
  }
}

data "linuxkit_file" "nomad_base" {
  path     = "etc/nomad/25-base.hcl"
  source   = "${path.module}/files/nomad/25-base.hcl"
  mode     = "0644"
  optional = false
}

data "linuxkit_file" "nomad_server" {
  path     = "etc/nomad/40-server.hcl"
  source   = "${path.module}/files/nomad/40-server.hcl"
  mode     = "0644"
  optional = false
}

data "linuxkit_file" "nomad_client" {
  path     = "etc/nomad/40-client.hcl"
  source   = "${path.module}/files/nomad/40-client.hcl"
  mode     = "0644"
  optional = false
}

data "template_file" "nomad_acl" {
  template = file("${path.module}/tmpl/nomad/10-acl.hcl.tpl")
  vars = {
    nomad_acl_enabled = var.nomad_acl
  }
}

data "linuxkit_file" "nomad_acl" {
  path     = "etc/nomad/10-acl.hcl"
  contents = data.template_file.nomad_acl.rendered
  mode     = "0644"
  optional = false
}
