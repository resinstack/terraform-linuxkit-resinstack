terraform {
  required_providers {
    linuxkit = {
      source  = "resinstack/linuxkit"
      version = "0.0.3"
    }
  }
}

provider "linuxkit" {}

module "all_in_one" {
  source = "../../"

  enable_console = true

  consul_server = true
}

data "linuxkit_metadata" "aio" {
  base_path = "${path.module}/metadata"
}

resource "local_file" "aio_metadata" {
  content  = data.linuxkit_metadata.aio.json
  filename = "${path.root}/metadata.json"

  file_permission = "0644"
}
