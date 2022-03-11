controller {
  name = "demo-controller-1"
  description = "A controller for a demo!"

  database {
    url = "postgresql://boundary:boundary@localhost:5432/boundary?sslmode=disable"
  }
}

worker {
  name = "demo-worker-1"
  description = "A default worker created demonstration"

  controllers = ["localhost"]
}

listener "tcp" {
  purpose = "api"
  tls_disable = true

  address = "0.0.0.0"
}

listener "tcp" {
  purpose = "proxy"
  tls_disable = true

  address = "127.0.0.1"
}

listener "tcp" {
  address = "127.0.0.1"
  purpose = "cluster"
}

kms "aead" {
  purpose = "root"
  aead_type = "aes-gcm"
  key = "sP1fnF5Xz85RrXyELHFeZg9Ad2qt4Z4bgNHVGtD6ung="
  key_id = "global_root"
}

kms "aead" {
  purpose = "worker-auth"
  aead_type = "aes-gcm"
  key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
  key_id = "global_worker-auth"
}

kms "aead" {
  purpose = "recovery"
  aead_type = "aes-gcm"
  key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
  key_id = "global_recovery"
}
