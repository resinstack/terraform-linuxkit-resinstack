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
  default     = "8f1e6a0747acbbb4d7e24dc98f97faa8d1c6cec7"
}

variable "system_version_runit" {
  type        = string
  description = "Use a different version of runit"
  default     = "v0.1.1"
}

variable "system_version_runc" {
  type        = string
  description = "Use a different runc than the unified version number"
  default     = "f01b88c7033180d50ae43562d72707c6881904e4"
}

variable "system_version_containerd" {
  type        = string
  description = "Use a different containerd than the unified version number"
  default     = "de1b18eed76a266baa3092e5c154c84f595e56da"
}

variable "system_version_ca_certificates" {
  type        = string
  description = "Use a different ca_certificates than the unified version number"
  default     = "c1c73ef590dffb6a0138cf758fe4a4305c9864f4"
}

variable "system_version_sysctl" {
  type        = string
  description = "Use a different sysctl than the unified version number"
  default     = "bdc99eeedc224439ff237990ee06e5b992c8c1ae"
}

variable "system_version_sysfs" {
  type        = string
  description = "Use a different sysfs than the unified version number"
  default     = "0148c62dbf57948849e8da829d36363b94a76c97"
}

variable "system_version_dhcpcd" {
  type        = string
  description = "Use a different dhcpcd than the unified version number"
  default     = "52d2c4df0311b182e99241cdc382ff726755c450"
}

variable "system_version_acpid" {
  type        = string
  description = "Use a different acpid than the unified version number"
  default     = "c05a368754f6436b326945dc16135ba547568d8d"
}

variable "system_version_metadata" {
  type        = string
  description = "Use a different metadata than the unified version number"
  default     = "646c00ad6c0b3fc246b6af9ccfcd6b1eb6b6da8a"
}

variable "system_version_getty" {
  type        = string
  description = "Use a different getty than the unified version number"
  default     = "76951a596aa5e0867a38e28f0b94d620e948e3e8"
}

variable "system_version_sshd" {
  type        = string
  description = "Use a different sshd than the unified version number"
  default     = "7e71b29a4223436c741d73149f880f7bf5d44dd7"
}

variable "system_version_rngd" {
  type        = string
  description = "Use a different rngd than the unified version number"
  default     = "4f85d8de3f6f45973a8c88dc8fba9ec596e5495a"
}

variable "system_version_ntpd" {
  type        = string
  description = "Use a different ntpd than the unified version number"
  default     = "d6c36ac367ed26a6eeffd8db78334d9f8041b038"
}

variable "system_version_format" {
  type        = string
  description = "Use a different format than the unified version number"
  default     = "7efa07559dd23cb4dbebfd3ab48c50fd33625918"
}

variable "system_version_mount" {
  type        = string
  description = "Use a different mount than the unified version number"
  default     = "422b219bb1c7051096126ac83e6dcc8b2f3f1176"
}

variable "system_version_logwrite" {
  type        = string
  description = "Use a different logwrite than the unified version number"
  default     = "4d8aa07d4a7130239fc62b09f33e3401ecf62a38"
}

variable "system_version_memlogd" {
  type        = string
  description = "Use a different memlogd than the unified version number"
  default     = "014f86dce2ea4bb2ec13e92ae5c1e854bcefec40"
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

variable "system_ntpd_constraints" {
  type        = string
  description = "HTTPS domain or IP to retrieve constriants from"
  default     = "https://www.google.com"
}

variable "system_format_cmd" {
  type        = list(string)
  description = "Command to run for formatting persistent disk"
  default     = ["/usr/bin/format"]
}
