variable "vault_agent" {
  type        = bool
  description = "Enable the vault agent"
  default     = false
}

variable "vault_server" {
  type        = bool
  description = "Enable the vault server"
  default     = false
}

variable "vault_version" {
  type        = string
  description = "Vault server version"
  default     = "1.12.1"
}

variable "vault_ui" {
  type        = bool
  description = "Enable the web UI"
  default     = true
}

variable "vault_agent_role" {
  type        = string
  description = "Vault role for this server image to assume"
}

variable "vault_agent_address" {
  type        = string
  description = "Address of the vault server"
}
