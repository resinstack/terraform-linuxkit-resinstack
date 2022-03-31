data "linuxkit_image" "consul" {
  name  = "consul"
  image = "hashicorp/consul:${var.consul_version}"

  command = ["/usr/bin/runsv", "/service/consul"]

  binds = [
    "/etc/consul:/etc/consul",
    "/run/runit:/run/runit:rshared",
    "/run/config/consul:/run/config/consul",
    "/run/resolvconf/resolv.conf:/etc/resolv.conf",
    "/service:/service",
    "/usr/bin/runsv:/usr/bin/runsv",
    "/var/persist:/var/persist",
  ]

  runtime {
    mkdir = [
      "/var/persist/consul",
      "/var/run/config/consul",
      "/run/runit/supervise.consul",
    ]
  }
}

data "linuxkit_file" "consul_svc" {
  path     = "service/consul/run"
  contents = "#!/bin/sh\nexec /bin/consul agent -config-dir /etc/consul -config-dir /run/config/consul\n"
  mode     = "0755"
  optional = false
}

data "linuxkit_file" "consul_spr" {
  path     = "service/consul/supervise"
  symlink  = "/run/runit/supervise.consul"
  optional = false
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

data "linuxkit_file" "consul_acl" {
  path = "etc/consul/10-acl.hcl"
  contents = templatefile("${path.module}/tmpl/consul/10-acl.hcl.tpl", {
    consul_acl  = var.consul_acl
    acl_enabled = var.consul_acl_enabled
  })
  mode     = "0644"
  optional = false
}
