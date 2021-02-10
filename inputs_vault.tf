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

variable "vault_address" {
  type        = string
  description = "Vault bind address"
  default     = "0.0.0.0:8200"
}

variable "vault_tls_disable" {
  type        = bool
  description = "Disable TLS on Vault's bind -- NOT RECOMMENDED"
  default     = false
}
