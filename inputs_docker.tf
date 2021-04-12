variable "docker_version" {
  type        = string
  description = "Docker version to run"
  default     = "20.10.6-dind"
}

variable "enable_docker" {
  type        = bool
  description = "Include docker support"
  default     = false
}
