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
  default     = "a68f9fa0c1d9dbfc9c23663749a0b7ac510cbe1c"
}

variable "system_version_runc" {
  type        = string
  description = "Use a different runc than the unified version number"
  default     = ""
}

variable "system_version_containerd" {
  type        = string
  description = "Use a different containerd than the unified version number"
  default     = "1ae8f054e9fe792d1dbdb9a65f1b5e14491cb106"
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

variable "system_version_ntpd" {
  type        = string
  description = "Use a different ntpd than the unified version number"
  default     = ""
}

variable "system_version_format" {
  type        = string
  description = "Use a different format than the unified version number"
  default     = ""
}

variable "system_version_mount" {
  type        = string
  description = "Use a different mount than the unified version number"
  default     = ""
}

variable "enable_persist" {
  type        = bool
  description = "Enable persistence for /var/persist.  Consumes the first unformatted disk"
  default     = false
}

variable "system_metadata_providers" {
  type        = list(string)
  description = "List of metadata providers"
  default     = []
}

variable "system_containerd_log_level" {
  type        = string
  description = "Log level for containerd"
  default     = "info"
}

variable "system_ntpd_servers" {
  type        = string
  description = "DNS hostname or single IP pointing to ntp sync source"
  default     = "pool.ntp.org"
}
