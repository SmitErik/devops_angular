# modules/database/docker/main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

resource "docker_image" "database" {
  name = "database:latest"
  build {
    context    = "."
    dockerfile = "Dockerfile_database"
    tag        = ["database:latest"]
    no_cache   = true
  }
}

resource "docker_container" "database" {
  name  = "${var.container_name}"
  hostname = "${var.container_name}"
  image = docker_image.database.image_id
  
  # Port mapping
  ports {
    internal = var.app_port
    external = var.app_port
  }
  
  # Hálózat csatlakozás
  networks_advanced {
    name = "${var.project_name}_network"
    ipv4_address = "172.100.0.10"
  }
}

# Output a container_name használatához
output "container_name" {
  value = var.container_name
}