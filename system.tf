data "linuxkit_kernel" "kernel" {
  image   = var.system_kernel_image
  cmdline = var.system_kernel_cmdline
}

data "linuxkit_init" "init" {
  containers = [
    "linuxkit/init:${var.system_version_init != "" ? var.system_version_init : var.system_version_unified}",
    "linuxkit/runc:${var.system_version_runc != "" ? var.system_version_runc : var.system_version_unified}",
    "linuxkit/containerd:${var.system_version_containerd != "" ? var.system_version_containerd : var.system_version_unified}",
    "linuxkit/ca-certificates:${var.system_version_ca_certificates != "" ? var.system_version_ca_certificates : var.system_version_unified}",
    "linuxkit/memlogd:${var.system_version_memlogd != "" ? var.system_version_memlogd : var.system_version_unified}",
    "ghcr.io/resinstack/runit:${var.system_version_runit}",
  ]
}

data "linuxkit_image" "sysctl" {
  name  = "sysctl"
  image = "linuxkit/sysctl:${var.system_version_sysctl != "" ? var.system_version_sysctl : var.system_version_unified}"
}

data "linuxkit_image" "sysfs" {
  name  = "sysfs"
  image = "linuxkit/sysfs:${var.system_version_sysfs != "" ? var.system_version_sysfs : var.system_version_unified}"
}

data "linuxkit_image" "dhcp_boot" {
  name    = "dhcpcd_boot"
  image   = "linuxkit/dhcpcd:${var.system_version_dhcpcd != "" ? var.system_version_dhcpcd : var.system_version_unified}"
  command = ["/sbin/dhcpcd", "--nobackground", "-d", "-f", "/dhcpcd.conf", "-1", "-4"]
}

data "linuxkit_image" "dhcp_svc" {
  name  = "dhcpcd"
  image = "linuxkit/dhcpcd:${var.system_version_dhcpcd != "" ? var.system_version_dhcpcd : var.system_version_unified}"
}

data "linuxkit_image" "acpid" {
  name  = "acpid"
  image = "linuxkit/acpid:${var.system_version_acpid != "" ? var.system_version_acpid : var.system_version_unified}"
}

data "linuxkit_image" "metadata" {
  name    = "metadata"
  image   = "linuxkit/metadata:${var.system_version_metadata != "" ? var.system_version_metadata : var.system_version_unified}"
  command = flatten([["/usr/bin/metadata"], var.system_metadata_providers])
}

data "linuxkit_image" "getty" {
  name  = "getty"
  image = "linuxkit/getty:${var.system_version_getty != "" ? var.system_version_getty : var.system_version_unified}"
  env   = ["INSECURE=true"]
}

data "linuxkit_image" "sshd" {
  name  = "sshd"
  image = "linuxkit/sshd:${var.system_version_sshd != "" ? var.system_version_sshd : var.system_version_unified}"
  binds = [
    "/run/config/ssh/authorized_keys:/root/.ssh/authorized_keys",
  ]
}

data "linuxkit_image" "rngd_boot" {
  name    = "rngd_boot"
  image   = "linuxkit/rngd:${var.system_version_rngd != "" ? var.system_version_rngd : var.system_version_unified}"
  command = ["/sbin/rngd", "-1"]
}

data "linuxkit_image" "rngd_svc" {
  name  = "rngd"
  image = "linuxkit/rngd:${var.system_version_rngd != "" ? var.system_version_rngd : var.system_version_unified}"
}

data "linuxkit_image" "ntpd" {
  name  = "openntpd"
  image = "linuxkit/openntpd:${var.system_version_ntpd != "" ? var.system_version_ntpd : var.system_version_unified}"

  binds = [
    "/etc/ntpd.conf:/etc/ntpd.conf",
  ]
}

data "linuxkit_image" "format" {
  name  = "openformat"
  image = "linuxkit/format:${var.system_version_format != "" ? var.system_version_format : var.system_version_unified}"
}

data "linuxkit_image" "mount" {
  name    = "openmount"
  image   = "linuxkit/mount:${var.system_version_mount != "" ? var.system_version_mount : var.system_version_unified}"
  command = ["/usr/bin/mountie", "/var/persist"]

  runtime {
    mkdir = ["var/persist"]
  }
}

data "linuxkit_image" "logwrite" {
  name  = "logwrite"
  image = "linuxkit/logwrite:${var.system_version_logwrite != "" ? var.system_version_logwrite : var.system_version_unified}"
}

data "template_file" "containerd_toml" {
  template = file("${path.module}/tmpl/system/runtime-config.toml.tpl")
  vars = {
    log_level = var.system_containerd_log_level
  }
}

data "linuxkit_file" "containerd_toml" {
  path     = "etc/containerd/runtime-config.toml"
  contents = data.template_file.containerd_toml.rendered
  mode     = "0644"
  optional = false
}

data "linuxkit_file" "ntpd_conf" {
  contents = "servers ${var.system_ntpd_servers}\n"
  path     = "etc/ntpd.conf"
  mode     = "0644"
  optional = false
}
