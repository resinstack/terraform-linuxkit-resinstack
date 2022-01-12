data "linuxkit_image" "emissary" {
  name  = "emissary"
  image = "ghcr.io/resinstack/emissary:${var.emissary_version}"

  capabilities = ["all"]

  binds = [
    "/etc/resolv.conf:/etc/resolv.conf",
    "/run:/run",
    "/service:/service",
    "/usr/bin/sv:/usr/bin/sv",
  ]

  env = [
    "EMISSARY_TPL_DIR=/run/config/emissary",
    "EMISSARY_INSECURE_URLFILE=/run/config/emissary_insecureurl",
  ]
}
