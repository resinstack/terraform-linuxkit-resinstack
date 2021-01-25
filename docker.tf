data "linuxkit_image" "docker" {
  name  = "docker"
  image = "docker:${var.docker_version}"

  command = ["/usr/local/bin/docker-init", "/usr/local/bin/dockerd"]

  capabilities = ["all"]

  mounts {
    type    = "cgroup"
    options = ["rw", "nosuid", "noexec", "nodev", "relatime"]
  }

  binds = [
    "/etc/docker/daemon.json:/etc/docker/daemon.json",
    "/etc/resolv.cluster:/etc/resolv.conf",
    "/lib/modules:/lib/modules",
    "/run:/run:shared",
    "/var/persist:/var/persist:rshared",
  ]

  rootfs_propagation = "shared"

  runtime {
    mkdir = [
      "/var/lib/docker",
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
