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
}
