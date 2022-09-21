vault {
  address = "${vault_address}"
  ca_cert = "/run/config/step/root_ca.crt"
}

auto_auth {
  method {
    type = "cert"
    mount_path = "auth/resin_fleet"

    config = {
      name = "${vault_role}"
      ca_cert = "/run/config/step/root_ca.crt"
      client_cert = "/run/config/step/node.crt"
      client_key = "/run/config/step/node.key"
    }
  }

  sink {
    type = "file"

    config = {
      path = "/tmp/.host-token"
    }
  }
}

%{if enable_consul}
template {
  source = "/etc/vault-agent/consul.tpl"
  destination = "/run/config/consul/90-secret.hcl"
  exec = {
    command = ["/usr/bin/sv", "reload", "consul"]
  }
}
%{endif}
%{if enable_vault}
template {
  source = "/etc/vault-agent/vault.tpl"
  destination = "/run/config/vault/90-secret.hcl"
  exec = {
    command = ["/usr/bin/sv", "restart", "vault"]
  }
}
%{endif}
%{if nomad_server}
template {
  source = "/etc/vault-agent/nomad-server.tpl"
  destination = "/run/config/nomad/90-secret.hcl"
  exec = {
    command = ["/usr/bin/sv", "restart", "nomad"]
  }
}
%{endif}
%{if nomad_client && !nomad_server}
template {
  source = "/etc/vault-agent/nomad-client.tpl"
  destination = "/run/config/nomad/90-secret.hcl"
  exec = {
    command = ["/usr/bin/sv", "restart", "nomad"]
  }
}
%{endif}
