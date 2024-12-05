# modules/server/docker/main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

resource "docker_image" "server" {
  name = "server:latest"
  build {
    context    = "."
    dockerfile = "Dockerfile_server"
    tag        = ["server:latest"]
    no_cache   = true
  }
}

resource "docker_container" "server" {
  name  = "${var.container_name}"
  hostname = "${var.container_name}"
  image = docker_image.server.image_id

  # Port mapping
  ports {
    internal = var.app_port
    external = var.app_port
  }
  
  # Hálózat csatlakozás
  networks_advanced {
    name = "${var.project_name}_network"
    ipv4_address = "172.100.0.20"
  }
}

# Output a container_name használatához
output "container_name" {
  value = var.container_name
}