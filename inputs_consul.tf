variable "consul_version" {
  type        = string
  description = "Version of Consul to run"
  default     = "1.9.1"
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

variable "consul_default_deny" {
  type        = bool
  description = "Enable a default-deny ACL policy"
  default     = true
}
