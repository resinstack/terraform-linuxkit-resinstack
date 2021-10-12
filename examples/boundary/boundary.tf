terraform {
  required_providers {
    linuxkit = {
      source  = "resinstack/linuxkit"
      version = "0.0.4"
    }
  }
}

provider "linuxkit" {}

module "boundary" {
  source = "../../"

  enable_console  = true
  enable_emissary = true

  enable_consul = false
  enable_docker = false

  enable_boundary = true

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
