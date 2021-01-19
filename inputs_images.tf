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
