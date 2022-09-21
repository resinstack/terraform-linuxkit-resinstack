data "linuxkit_image" "vault" {
  name  = "vault"
  image = "hashicorp/vault:${var.vault_version}"

  command = ["/usr/bin/runsv", "/service/vault"]

  capabilities = [
    "CAP_SETUID",
    "CAP_SETGID",
    "CAP_IPC_LOCK",
  ]

  binds = [
    "/etc/resolv.cluster:/etc/resolv.conf",
    "/etc/vault:/etc/vault",
    "/run:/run:rshared",
    "/service:/service",
    "/usr/bin/runsv:/usr/bin/runsv",
    "/var:/var:rshared",
  ]

  runtime {
    mkdir = [
      "/var/persist/vault",
      "/var/run/config/vault",
      "/run/runit/supervise.vault",
    ]
  }
}

data "linuxkit_file" "vault_svc" {
  path     = "service/vault/run"
  contents = "#!/bin/sh\nexec /bin/vault server -config /run/config/vault -config /etc/vault\n"
  mode     = "0755"
  optional = false
}

data "linuxkit_file" "vault_spr" {
  path     = "service/vault/supervise"
  symlink  = "/run/runit/supervise.vault"
  optional = false
}

data "linuxkit_file" "vault_ui" {
  path = "etc/vault/10-ui.hcl"

  contents = "ui = true\n"
  mode     = "0644"
  optional = false
}

data "linuxkit_file" "vault_cert_reload" {
  path     = "usr/libexec/step/on-renew/50-vault-reload"
  contents = "#!/bin/sh\n/usr/bin/sv reload vault\n"
  mode     = "0755"
  optional = false
}
