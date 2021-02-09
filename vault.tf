data "linuxkit_image" "vault" {
  name  = "vault"
  image = "vault:${var.vault_version}"

  command = [
    "/bin/vault", "server",
    "-config", "/var/run/config/vault",
  ]

  capabilities = [
    "CAP_SETUID",
    "CAP_SETGID",
    "CAP_IPC_LOCK",
  ]

  binds = [
    "/var/run/config/vault:/var/run/config/vault",
    "/etc/resolv.cluster:/etc/resolv.conf",
  ]

  runtime {
    mkdir = [
      "/var/run/config/vault",
    ]
  }
}
