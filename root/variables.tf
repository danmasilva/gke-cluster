
variable "node_username" {
  default = "ubuntu"
}

variable "ssh_key_file_name" {
  default = "rancher_master_key"
}

variable "project_id" {
  default = "rancher-project-309022"
}

variable "region" {
  default = "us-west1"
}

variable "rancher_master_machine_type" {
  default = "e2-medium"
}

variable "rancher_image" {
  default = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"
}

variable "docker_version" {
  default     = "19.03"
}

variable "network_name" {
  description = "rede onde serao criados os nos do cluster"
  default = "default_network"
}

variable "subnetwork_name" {
  description = "subrede onde serao criados os nos do cluster"
  default = "default_subnetwork"
}

variable "gke_username" {
  default = "ubuntu"
}

variable "gke_password" {
  default = "ubuntuubuntuubuntu"
}

variable "gke_num_nodes" {
  default = 1
}