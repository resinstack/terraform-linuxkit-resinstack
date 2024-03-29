data "linuxkit_image" "step" {
  name  = "step"
  image = "smallstep/step-ca:${var.step_version}"

  command      = ["/usr/local/bin/node-certificate"]
  capabilities = ["CAP_NET_BIND_SERVICE"]

  binds = [
    "/run:/run",
    "/service:/service",
    "/usr/bin/sv:/usr/bin/sv",
    "/usr/libexec/step/on-renew:/usr/libexec/step/on-renew",
    "/usr/local/bin/node-certificate:/usr/local/bin/node-certificate",
  ]
}

data "linuxkit_file" "step" {
  path     = "usr/local/bin/node-certificate"
  source   = "${path.module}/files/step/certs.sh"
  mode     = "0755"
  optional = false
}
