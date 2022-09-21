variable "enable_step" {
  type        = bool
  description = "Enable step machine certificate management"
  default     = true
}

variable "step_version" {
  type        = string
  description = "Version of the step tools to install"
  default     = "0.19.0"
}
