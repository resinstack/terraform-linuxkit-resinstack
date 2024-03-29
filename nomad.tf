data "linuxkit_image" "nomad" {
  name  = "nomad"
  image = "ghcr.io/resinstack/nomad:${var.nomad_version}"

  command = ["/usr/bin/runsv", "/service/nomad"]

  capabilities = [
    "CAP_CHOWN",
    "CAP_NET_ADMIN",
    "CAP_SYS_ADMIN",
  ]

  binds = [
    "/etc/nomad:/etc/nomad",
    "/etc/resolv.cluster:/etc/resolv.conf",
    "/lib/modules:/lib/modules",
    "/run:/run:rshared",
    "/service:/service",
    "/usr/bin/runsv:/usr/bin/runsv",
    "/var:/var:rshared",

    # This looks really really dumb, but hear me out: Nomad needs to
    # see the consul binary while doing connect things.  Rather than
    # trying to include it with this nomad container and potentially
    # including an out of date version and then needing to maintain
    # two update criteria, we cheat and mount in the one that's at a
    # particularly magic path from the adjacent consul service
    # container.  Don't try this at home, filmed on a closed course,
    # void where prohibited.
    "/containers/services/consul/lower/bin/consul:/usr/local/bin/consul",
  ]

  rootfs_propagation = "shared"

  runtime {
    mkdir = flatten([[
      "/var/persist/nomad",
      "/var/run/config/nomad",
      "/run/runit/supervise.nomad",
      ],
      var.nomad_mkdirs,
    ])
  }
}

data "linuxkit_file" "nomad_svc" {
  path     = "service/nomad/run"
  contents = "#!/bin/sh\nexec /usr/local/bin/nomad agent -config /etc/nomad -config /run/config/nomad\n"
  mode     = "0755"
  optional = false
}

data "linuxkit_file" "nomad_spr" {
  path     = "service/nomad/supervise"
  symlink  = "/run/runit/supervise.nomad"
  optional = false
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

data "linuxkit_file" "nomad_acl" {
  path = "etc/nomad/10-acl.hcl"
  contents = templatefile("${path.module}/tmpl/nomad/10-acl.hcl.tpl", {
    nomad_acl_enabled = var.nomad_acl
  })
  mode     = "0644"
  optional = false
}

data "linuxkit_file" "nomad_client_vault" {
  path = "etc/nomad/50-vault.hcl"

  contents = <<EOT
vault {
  enabled = true
  address = "http://active.vault.service.consul:8200"
}
EOT

  mode     = "0644"
  optional = false
}
