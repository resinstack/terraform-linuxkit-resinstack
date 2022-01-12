variable "system_kernel_image" {
  type        = string
  description = "Image containing a kernel and modules"
  default     = "linuxkit/kernel:5.10.76"
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
  default     = "eb597ef74d808b5320ad1060b1620a6ac31e7ced"
}

variable "system_version_runit" {
  type = string
  description = "Use a different version of runit"
  default = "v0.1.1"
}

variable "system_version_runc" {
  type        = string
  description = "Use a different runc than the unified version number"
  default     = "9f7aad4eb5e4360cc9ed8778a5c501cce6e21601"
}

variable "system_version_containerd" {
  type        = string
  description = "Use a different containerd than the unified version number"
  default     = "2f0907913dd54ab5186006034eb224a0da12443e"
}

variable "system_version_ca_certificates" {
  type        = string
  description = "Use a different ca_certificates than the unified version number"
  default     = "c1c73ef590dffb6a0138cf758fe4a4305c9864f4"
}

variable "system_version_sysctl" {
  type        = string
  description = "Use a different sysctl than the unified version number"
  default     = "0dc8f792fc3a58afcebcb0fbe6b48de587265c17"
}

variable "system_version_sysfs" {
  type = string
  description = "Use a different sysfs than the unified version number"
  default = "0148c62dbf57948849e8da829d36363b94a76c97"
}

variable "system_version_dhcpcd" {
  type        = string
  description = "Use a different dhcpcd than the unified version number"
  default     = ""
}

variable "system_version_acpid" {
  type        = string
  description = "Use a different acpid than the unified version number"
  default     = "e9a94e593d6be2fc1b3eb6d566f23ac9ca9807fd"
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

variable "system_version_logwrite" {
  type = string
  description = "Use a different logwrite than the unified version number"
  default = "568325cf294338b37446943c2b86a8cd8dc703db"
}

variable "system_version_memlogd" {
  type = string
  description = "Use a different memlogd than the unified version number"
  default = "fe4a123b619a7dfffc2ba1297dd03b4ac90e3dd7"
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
