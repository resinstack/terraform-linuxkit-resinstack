consul {
    token = "{{ with secret "resin_internal/nomad/client_consul" }}{{ .Data.data.token }}{{ end }}"
}
