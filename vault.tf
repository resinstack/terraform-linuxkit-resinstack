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
    "/service:/service",
    "/usr/bin/runsv:/usr/bin/runsv",
    "/run/config/vault:/run/config/vault",
    "/run/runit:/run/runit:rshared",
    "/etc/resolv.cluster:/etc/resolv.conf",
    "/etc/vault:/etc/vault",
  ]

  runtime {
    mkdir = [
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
