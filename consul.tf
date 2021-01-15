data "linuxkit_image" "consul" {
  name  = "consul"
  image = "consul:${var.consul_version}"

  command = [
    "/bin/consul", "agent",
    "-config-dir", "/etc/consul",
    "-config-dir", "/var/run/config/consul"
  ]

  capabilities = ["CAP_SETUID", "CAP_SETGID"]

  binds = [
    "/etc/consul:/etc/consul",
    "/run/resolvconf/resolv.conf:/etc/resolv.conf",
    "/var/persist:/var/persist",
    "/var/run/config/consul:/var/run/config/consul",
  ]

  runtime {
    mkdir = [
      "/var/persist/consul",
      "/var/run/config/consul",
    ]
  }
}

data "linuxkit_file" "consul_base" {
  path     = "etc/consul/25-base.hcl"
  source   = "${path.module}/files/consul/25-base.hcl"
  mode     = "0644"
  optional = false
}

data "linuxkit_file" "consul_server" {
  path     = "etc/consul/40-server.hcl"
  source   = "${path.module}/files/consul/40-server.hcl"
  mode     = "0644"
  optional = false
}
