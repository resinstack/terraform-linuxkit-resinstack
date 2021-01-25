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
  default     = "v1.0.0r1"
}
