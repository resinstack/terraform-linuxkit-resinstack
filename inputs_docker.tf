variable "docker_version" {
  type        = string
  description = "Docker version to run"
  default     = "18.06.0-ce-dind"
}

variable "enable_docker" {
  type        = bool
  description = "Include docker support"
  default     = false
}
