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

data "template_file" "vault_listener" {
  template = file("${path.module}/tmpl/vault/10-listener.hcl")
  vars = {
    address     = var.vault_address
    tls_disable = var.vault_tls_disable
  }
}

data "linuxkit_file" "vault_listener" {
  path = "etc/vault/10-listener.hcl"

  contents = data.template_file.vault_listener.rendered
  mode     = "0644"
  optional = false
}

data "linuxkit_file" "vault_ui" {
  path = "etc/vault/10-ui.hcl"

  contents = "ui = true\n"
  mode     = "0644"
  optional = false
}
