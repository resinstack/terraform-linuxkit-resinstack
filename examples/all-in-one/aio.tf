terraform {
  required_providers {
    linuxkit = {
      source = "resinstack/linuxkit"
    }
  }
}

provider "linuxkit" {}

module "all_in_one" {
  source = "../../"

  enable_console  = true
  enable_emissary = true

  consul_server      = true
  consul_acl         = "allow"
  consul_acl_enabled = false

  nomad_server            = true
  nomad_client            = true
  nomad_acl               = false
  nomad_vault_integration = false

  vault_server = true

  enable_docker = true

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
