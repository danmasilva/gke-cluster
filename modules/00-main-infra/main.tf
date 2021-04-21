
resource "tls_private_key" "global_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
#private key
resource "local_file" "ssh_private_key_pem" {
  filename          = "../keys/${var.ssh_key_file_name}"
  sensitive_content = tls_private_key.global_key.private_key_pem
  file_permission   = "0600"
}

#public key
resource "local_file" "ssh_public_key_openssh" {
  filename = "../keys/${var.ssh_key_file_name}.pub"
  content  = tls_private_key.global_key.public_key_openssh
}

# GCP Public Compute Address for rancher server node
resource "google_compute_address" "rancher_server_address" {
  name = "rancher-server-ipv4-address"
}

# Firewall Rule to allow all traffic
resource "google_compute_firewall" "rancher_fw_allowall" {
  name    = "rancher-fw-allowall"
  network = "default"

  allow {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.0.0.0/24"
}
