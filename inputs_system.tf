variable "system_kernel_image" {
  type        = string
  description = "Image containing a kernel and modules"
  default     = "linuxkit/kernel:5.6.11"
}

variable "system_kernel_cmdline" {
  type        = string
  description = "Kernel command line"
  default     = "console=tty0 console=ttyS0 console=ttyAMA0"
}

variable "system_version_unified" {
  type        = string
  description = "Unified system version number"
  default     = "v0.8"
}

variable "system_version_init" {
  type        = string
  description = "Use a different init than the unified version number"
  default     = ""
}

variable "system_version_runc" {
  type        = string
  description = "Use a different runc than the unified version number"
  default     = ""
}

variable "system_version_containerd" {
  type        = string
  description = "Use a different containerd than the unified version number"
  default     = ""
}

variable "system_version_ca_certificates" {
  type        = string
  description = "Use a different ca_certificates than the unified version number"
  default     = ""
}

variable "system_version_sysctl" {
  type        = string
  description = "Use a different sysctl than the unified version number"
  default     = ""
}

variable "system_version_dhcpcd" {
  type        = string
  description = "Use a different dhcpcd than the unified version number"
  default     = ""
}

variable "system_version_acpid" {
  type        = string
  description = "Use a different acpid than the unified version number"
  default     = ""
}

variable "system_version_metadata" {
  type        = string
  description = "Use a different metadata than the unified version number"
  default     = ""
}

variable "system_version_getty" {
  type        = string
  description = "Use a different getty than the unified version number"
  default     = ""
}

variable "system_version_sshd" {
  type        = string
  description = "Use a different sshd than the unified version number"
  default     = ""
}

variable "system_version_rngd" {
  type        = string
  description = "Use a different rngd than the unified version number"
  default     = ""
}
