terraform {
  required_providers {
    linuxkit = {
      source  = "resinstack/linuxkit"
      version = "0.0.4"
    }
  }
}

provider "linuxkit" {}

data "linuxkit_image" "node_exporter" {
  name  = "node_exporter"
  image = "linuxkit/node_exporter:v0.8"
}

module "all_in_one" {
  source = "../../"

  enable_console  = true
  enable_emissary = true

  consul_server = true
  consul_acl    = "allow"

  nomad_server = true
  nomad_client = true
  nomad_acl    = false

  vault_server = true

  enable_docker = true

  custom_services = [data.linuxkit_image.node_exporter.id]

  build_raw_bios            = true
  system_metadata_providers = ["cdrom"]
}

data "linuxkit_metadata" "aio" {
  base_path = "${path.module}/metadata"
}

resource "local_file" "aio_metadata" {
  content  = data.linuxkit_metadata.aio.json
  filename = "${path.root}/metadata.json"

  file_permission = "0644"
}
