variable "output_to" {
  type        = string
  description = "Directory to contain artifacts"
  default     = ""
}

variable "build_raw_bios" {
  type        = bool
  description = "Build a raw BIOS image"
  default     = false
}

variable "build_pxe" {
  type        = bool
  description = "Build PXE files"
  default     = false
}

variable "build_aws" {
  type        = bool
  description = "Build AWS image"
  default     = false
}

variable "build_aws_size" {
  type        = number
  description = "Size in MB for the AWS image"
  default     = 1000
}

variable "build_vmdk" {
  type        = bool
  description = "Build VMDK image"
  default     = false
}
