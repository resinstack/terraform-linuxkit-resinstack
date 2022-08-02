encrypt = "{{ with secret "resin_internal/consul/gossip" }}{{ .Data.data.key }}{{ end }}"

acl {
  tokens {
    agent = "{{ with secret "consul/creds/agent" }}{{ .Data.token }}{{ end }}"
  }
}
