variable "nomad_server" {
  type        = bool
  description = "Enable Nomad server"
  default     = false
}

variable "nomad_client" {
  type        = bool
  description = "Enable Nomad client"
  default     = false
}

variable "nomad_version" {
  type        = string
  description = "Nomad version to run"
  default     = "v1.3.3r0"
}

variable "nomad_acl" {
  type        = bool
  description = "Enforce Nomad ACLs"
  default     = true
}

variable "nomad_vault_integration" {
  type        = bool
  description = "Enable Vault integration"
  default     = true
}

variable "nomad_mkdirs" {
  type        = list(string)
  description = "Supplemental directories to create before starting Nomad.  Useful for host volumes."
  default     = []
}
