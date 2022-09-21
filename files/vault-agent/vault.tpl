service_registration "consul" {
  token = "{{ with secret "resin_internal/vault/consul_token" }}{{ .Data.data.token }}{{ end }}"
}
