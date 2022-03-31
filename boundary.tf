data "linuxkit_image" "boundary" {
  name  = "boundary"
  image = "hashicorp/boundary:${var.boundary_version}"

  command = ["/usr/bin/runsv", "/service/boundary"]

  binds = [
    "/run/config:/run/config",
    "/run/runit:/run/runit:rshared",
    "/etc/resolv.conf:/etc/resolv.conf",
    "/service:/service",
    "/usr/bin/runsv:/usr/bin/runsv",
  ]

  capabilities = [
    "CAP_IPC_LOCK",
    "CAP_SETFCAP",
    "CAP_SETGID",
    "CAP_SETUID",
  ]

  runtime {
    mkdir = [
      "/run/runit/supervise.boundary",
    ]
  }
}

data "linuxkit_file" "boundary_svc" {
  path     = "service/boundary/run"
  contents = "#!/bin/sh\nexec boundary server -config /run/config/boundary/boundary.hcl\n"
  mode     = "0755"
  optional = false
}

data "linuxkit_file" "boundary_spr" {
  path     = "service/boundary/supervise"
  symlink  = "/run/runit/supervise.boundary"
  optional = false
}
