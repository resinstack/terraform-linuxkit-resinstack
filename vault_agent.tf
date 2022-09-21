data "linuxkit_image" "vault_agent" {
  name  = "vault-agent"
  image = "hashicorp/vault:${var.vault_version}"

  command = ["/usr/bin/runsv", "/service/vault-agent"]

  capabilities = [
    "CAP_SETUID",
    "CAP_SETGID",
    "CAP_IPC_LOCK",
  ]

  binds = [
    "/etc/resolv.cluster:/etc/resolv.conf",
    "/etc/vault-agent:/etc/vault-agent",
    "/run:/run:rshared",
    "/service:/service",
    "/usr/bin/runsv:/usr/bin/runsv",
    "/usr/bin/sv:/usr/bin/sv",
    "/var:/var:rshared",
  ]

  runtime {
    mkdir = [
      "/var/persist/vault-agent",
      "/run/config/vault-agent",
      "/run/runit/supervise.vault-agent",
    ]
  }
}

data "linuxkit_file" "vault_agent_svc" {
  path     = "service/vault-agent/run"
  contents = "#!/bin/sh\nexec /bin/vault agent -config /etc/vault-agent/config.hcl\n"
  mode     = "0755"
  optional = false
}

data "linuxkit_file" "vault_agent_spr" {
  path     = "service/vault-agent/supervise"
  symlink  = "/run/runit/supervise.vault-agent"
  optional = false
}

data "linuxkit_file" "vault_agent_cert_reload" {
  path     = "usr/libexec/step/on-renew/50-vault-agent-reload"
  contents = "#!/bin/sh\n/usr/bin/sv reload vault-agent\n"
  mode     = "0755"
  optional = false
}

data "linuxkit_file" "vault_agent_config" {
  path = "etc/vault-agent/config.hcl"
  contents = templatefile("${path.module}/tmpl/vault-agent/agent.hcl", {
    enable_consul = var.enable_consul,
    enable_vault  = var.vault_server,
    nomad_server  = var.nomad_server,
    nomad_client  = var.nomad_client,
    vault_role    = var.vault_agent_role,
    vault_address = var.vault_agent_address,
  })
  mode     = "0644"
  optional = false
}

data "linuxkit_file" "vault_agent_consul_tpl" {
  path     = "etc/vault-agent/consul.tpl"
  source   = "${path.module}/files/vault-agent/consul.tpl"
  mode     = "0644"
  optional = false
}

data "linuxkit_file" "vault_agent_server_tpl" {
  path     = "etc/vault-agent/vault.tpl"
  source   = "${path.module}/files/vault-agent/vault.tpl"
  mode     = "0644"
  optional = false
}

data "linuxkit_file" "vault_agent_nomad_server_tpl" {
  path     = "etc/vault-agent/nomad-server.tpl"
  source   = "${path.module}/files/vault-agent/nomad-server.tpl"
  mode     = "0644"
  optional = false
}

data "linuxkit_file" "vault_agent_nomad_client_tpl" {
  path     = "etc/vault-agent/nomad-client.tpl"
  source   = "${path.module}/files/vault-agent/nomad-client.tpl"
  mode     = "0644"
  optional = false
}
