data "linuxkit_image" "emissary" {
  name  = "emissary"
  image = "ghcr.io/resinstack/emissary:${var.emissary_version}"

  capabilities = ["CAP_SYS_ADMIN"]

  binds = [
    "/containers:/containers",
    "/etc/resolv.cluster:/etc/resolv.conf",
    "/run:/run",
    "/usr/bin/ctr:/usr/bin/ctr",
    "/usr/bin/restart:/usr/bin/restart",
    "/usr/bin/service:/usr/bin/service",
  ]

  env = [
    "EMISSARY_TPL_DIR=/run/config/emissary",
    "EMISSARY_INSECURE_URLFILE=/run/config/emissary_insecureurl",
  ]
}

data "linuxkit_file" "emissary_restart" {
  path     = "usr/bin/restart"
  source   = "${path.module}/files/emissary/restart"
  mode     = "0755"
  optional = false
}
