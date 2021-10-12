variable "enable_boundary" {
  type        = bool
  description = "Enable Boundary"
  default     = false
}

variable "boundary_version" {
  type        = string
  description = "Version of boundary to run"
  default     = "0.6.2"
}
