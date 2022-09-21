server {
  encrypt = "{{ with secret "resin_internal/nomad/gossip" }}{{ .Data.data.key }}{{ end }}"
}

consul {
  token = "{{ with secret "resin_internal/nomad/server_consul" }}{{ .Data.data.token }}{{ end }}"
}

vault {
  token = "{{ with secret "resin_internal/nomad/vault" }}{{ .Data.data.token }}{{ end }}"
}
