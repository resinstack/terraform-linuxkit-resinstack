data "linuxkit_image" "vault" {
  name  = "vault"
  image = "vault:${var.vault_version}"

  command = [
    "/bin/vault", "server",
    "-config", "/var/run/config/vault",
    "-config", "/etc/vault",
  ]

  capabilities = [
    "CAP_SETUID",
    "CAP_SETGID",
    "CAP_IPC_LOCK",
  ]

  binds = [
    "/var/run/config/vault:/var/run/config/vault",
    "/etc/resolv.cluster:/etc/resolv.conf",
    "/etc/vault:/etc/vault",
  ]

  runtime {
    mkdir = [
      "/var/run/config/vault",
    ]
  }
}

data "linuxkit_file" "vault_api_addr" {
  path = "etc/vault/10-api.hcl"

  contents = "api_addr = \"${var.vault_api_addr}\"\n"
  mode     = "0644"
  optional = false
}
