variable "custom_onboot" {
  type        = list(string)
  description = "Additional tasks to run on-boot"
  default     = []
}

variable "custom_services" {
  type        = list(string)
  description = "Additional services to run"
  default     = []
}

variable "custom_files" {
  type        = list(string)
  description = "Additional files to add"
  default     = []
}
