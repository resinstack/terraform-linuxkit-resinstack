data "linuxkit_image" "boundary" {
  name  = "boundary"
  image = "hashicorp/boundary:${var.boundary_version}"

  command = [
    "/usr/local/bin/docker-entrypoint.sh", "server",
    "-config", "/run/config/boundary/boundary.hcl",
  ]

  binds = [
    "/run/config:/run/config",
    "/etc/resolv.conf:/etc/resolv.conf",
  ]

  capabilities = [
    "CAP_IPC_LOCK",
    "CAP_SETFCAP",
    "CAP_SETGID",
    "CAP_SETUID",
  ]
}
