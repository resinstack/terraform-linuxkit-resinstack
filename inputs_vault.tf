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

variable "vault_api_addr" {
  type        = string
  description = "Vault API Address"
  default     = "http://active.vault.service.consul:8200"
}
