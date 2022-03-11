terraform {
  required_providers {
    linuxkit = {
      source = "resinstack/linuxkit"
    }
  }
}

provider "linuxkit" {}

data "linuxkit_image" "postgres" {
  name  = "postgres"
  image = "postgres:14-alpine"

  command = ["/usr/local/bin/docker-entrypoint.sh", "postgres"]
  cwd     = "/usr/local/bin"

  capabilities = [
    "CAP_CHOWN",
    "CAP_SETUID",
    "CAP_SETGID",
  ]

  binds = [
    "/var/run:/var/run",
    "/var/persist/postgres:/var/lib/postgresql/data",
  ]

  env = [
    "LANG=en_US.utf8",
    "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    "PGDATA=/var/lib/postgresql/data",
    "PG_MAJOR=14",
    "PG_SHA256=2cf78b2e468912f8101d695db5340cf313c2e9f68a612fb71427524e8c9a977a",
    "PG_VERSION=14.2",
    "POSTGRES_PASSWORD=boundary",
    "POSTGRES_USER=boundary",
  ]

  runtime {
    mkdir = ["/var/persist/postgres"]
  }
}

module "boundary" {
  source = "../../"

  enable_console  = true
  enable_emissary = true

  enable_consul = false
  enable_docker = false

  enable_boundary = true

  custom_services = [data.linuxkit_image.postgres.id]

  build_raw_bios            = true
  system_metadata_providers = ["cdrom"]
}

data "linuxkit_metadata" "boundary" {
  base_path = "${path.module}/metadata"
}

resource "local_file" "boundary_metadata" {
  content  = data.linuxkit_metadata.boundary.json
  filename = "${path.root}/metadata.json"

  file_permission = "0644"
}
