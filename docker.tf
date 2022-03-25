data "linuxkit_image" "docker" {
  name  = "dockerd"
  image = "docker:${var.docker_version}"

  command = ["/usr/local/bin/docker-init", "/usr/local/bin/dockerd"]

  capabilities = ["all"]
  net          = "host"
  pid          = "host"

  mounts {
    type    = "cgroup"
    options = ["rw", "nosuid", "noexec", "nodev", "relatime"]
  }

  devices {
    path     = "/dev/console"
    type     = "c"
    major    = 5
    minor    = 1
    filemode = "0666"
  }

  devices {
    path = "all"
    type = "b"
  }

  binds = [
    "/dev:/dev",
    "/etc/docker/daemon.json:/etc/docker/daemon.json",
    "/etc/resolv.cluster:/etc/resolv.conf",
    "/lib/modules:/lib/modules",
    "/run:/run:rshared",
    "/var/run:/var/run:rshared",
    "/var/persist:/var/persist:rshared",
  ]

  rootfs_propagation = "shared"

  runtime {
    mkdir = [
      "/var/persist/docker",
    ]
  }
}

data "linuxkit_file" "docker_config" {
  path = "etc/docker/daemon.json"

  contents = jsonencode({
    dns       = ["172.26.64.1"]
    data-root = "/var/persist/docker"
    iptables  = false
    bridge    = "none"
  })

  mode     = "0644"
  optional = false
}
