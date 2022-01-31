output "config_yaml" {
  value       = data.linuxkit_config.build.yaml
  description = "Equivalent linuxkit configuration file"
}
