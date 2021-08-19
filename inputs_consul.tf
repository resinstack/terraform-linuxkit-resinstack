variable "consul_version" {
  type        = string
  description = "Version of Consul to run"
  default     = "1.10.1"
}

variable "enable_consul" {
  type        = bool
  description = "Include consul in the generated image"
  default     = true
}

variable "consul_server" {
  type        = bool
  description = "Enable Consul server resources"
  default     = false
}

variable "consul_acl" {
  type        = string
  description = "Policy to be used by consul"
  default     = "deny"

  validation {
    condition     = contains(["allow", "deny"], var.consul_acl)
    error_message = "Consul ACL must be either 'allow' or 'deny'."
  }
}

variable "consul_acl_enabled" {
  type        = bool
  description = "Enable the acl system"
  default     = true
}
