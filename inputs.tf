variable "base_name" {
  type        = string
  description = "Base name to apply to all resources"
  default     = "resinstack"
}

variable "enable_console" {
  type        = bool
  description = "Include getty in the image"
  default     = false
}

variable "enable_sshd" {
  type        = bool
  description = "Include sshd in the image"
  default     = false
}
