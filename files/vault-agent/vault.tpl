service_registration "consul" {
  token = "{{ with secret "consul/creds/vault" }}{{ .Data.token }}{{ end }}"
}
