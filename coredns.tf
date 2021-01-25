data "linuxkit_image" "coredns" {
  name         = "coredns"
  image        = "coredns/coredns:${var.coredns_version}"
  capabilities = ["CAP_NET_BIND_SERVICE"]

  binds = [
    "/etc/coredns/Corefile:/Corefile",
    "/run/resolvconf/resolv.conf:/etc/resolv.conf",
  ]
}

data "linuxkit_file" "coredns_corefile" {
  path     = "etc/coredns/Corefile"
  source   = "${path.module}/files/coredns/Corefile"
  mode     = "0644"
  optional = false
}

data "linuxkit_file" "coredns_resolvconf" {
  path     = "etc/resolv.cluster"
  source   = "${path.module}/files/coredns/resolv.cluster"
  mode     = "0644"
  optional = false
}
