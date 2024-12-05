# main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

# Közös hálózat létrehozása
resource "docker_network" "app_network" {
  name = "${var.project_name}_network"
  driver = "bridge"
  # Enable IPv6 if needed
  ipam_config {
    subnet = "172.100.0.0/16"  # Customize subnet as needed
    gateway = "172.100.0.1"
  }
  internal = false
}

# MongoDB modul
module "database" {
  source = "./modules/database"
  
  app_port = var.db_port
  container_name = "${var.project_name}_database"
}

# NodeJS alkalmazás modul
module "server" {
  source = "./modules/server"
  
  app_port = var.server_port
  container_name = "${var.project_name}_server"
}

# Angular alkalmazás modul
module "client" {
  source = "./modules/client"
  
  app_port = var.client_port
  container_name = "${var.project_name}_client"
}

output "network_info" {
  value = {
    network_id   = docker_network.app_network.id
    network_name = docker_network.app_network.name
  }
}