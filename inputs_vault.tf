variable "vault_server" {
  type        = bool
  description = "Enable the vault server"
  default     = false
}

variable "vault_version" {
  type        = string
  description = "Vault server version"
  default     = "1.6.2"
}

variable "vault_ui" {
  type        = bool
  description = "Enable the web UI"
  default     = true
}
