#maintainer: Daniel Marques


/*data "terraform_remote_state" "foo" {
  backend = "gcs"
  config = {
    bucket  = "bucket-terraform-test-tfstate"
    prefix  = "prod"
  }
}*/

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = "${var.region}-a"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

#00: create public ip, public/private keys and firewall
module "main-infra" {
  providers = {
    google = google
  }

  source = "../modules/00-main-infra"

  ssh_key_file_name = var.ssh_key_file_name
  project_id = var.project_id
  region = var.region
}

#01: create single rancher node
/*
module "single-rancher-node" {
  providers = {
    google = google
  }

  depends_on = [module.main-infra]
  source = "../modules/01-single-rancher-node"

  #vars
  region = var.region
  node_username = var.node_username
  rancher_image = var.rancher_image
  rancher_master_machine_type = var.rancher_master_machine_type

  #output vars
  rancher_server_address = module.main-infra.rancher_server_address
  ssh_public_key_openssh_filename = module.main-infra.ssh_public_key_openssh_filename
  ssh_public_key_openssh = module.main-infra.ssh_public_key_openssh
  ssh_private_key_openssh = module.main-infra.ssh_private_key_openssh

}*/

#02: create gke cluster
module "gke_cluster" {
  depends_on = [module.main-infra]

  source = "../modules/02-gke"
  project_id = var.project_id
  region = var.region
  network_name = module.main-infra.network_name
  subnetwork_name = module.main-infra.subnetwork_name
  gke_username = var.gke_username
  gke_password = var.gke_password
  gke_num_nodes = var.gke_num_nodes
}

#03: deploy nginx, 
module "helm_inicial_apps" {
  source = "../modules/03-helm-inicial-apps"
  depends_on = [module.gke_cluster]
}
