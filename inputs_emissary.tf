variable "enable_emissary" {
  type = bool
  description = "Include Emissary for one-shot secrets"
  default = true
}

variable "emissary_version" {
  type = string
  description = "Emissary version"
  default = "v0.3.0"
}
