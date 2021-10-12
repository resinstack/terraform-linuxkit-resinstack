data "linuxkit_image" "boundary" {
  name  = "boundary"
  image = "hashicorp/boundary:${var.boundary_version}"

  command = [
    "/usr/local/bin/docker-entrypoint.sh", "server",
    "-config", "/run/config/boundary/boundary.hcl",
  ]

  binds = [
    "/var/run/config/boundary:/var/run/config/boundary",
  ]

  capabilities = [
    "CAP_IPC_LOCK",
    "CAP_SETFCAP",
    "CAP_SETGID",
    "CAP_SETUID",
  ]
}
