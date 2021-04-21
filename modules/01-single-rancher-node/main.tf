resource "google_compute_instance" "rancher-master" {

  name = "rancher-master"
  machine_type = var.rancher_master_machine_type
  zone = "${var.region}-a"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.rancher_image
    }
  }

  network_interface {
    network = "default"
    access_config {
      #nat_ip = google_compute_address.rancher_server_address.address
      nat_ip = var.rancher_server_address
    }
  }

  #put public ssh key
  metadata = {
    ssh-keys = "${var.node_username}:${var.ssh_public_key_openssh}"
  }

  provisioner "remote-exec" {
    connection {
      host = var.rancher_server_address
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.ssh_private_key_openssh
      agent       = false
    }

    inline = [
      "sudo curl -sSL https://get.docker.com/ | sh",
      "sudo usermod -aG docker `echo $USER`",
      #"sudo docker run --privileged -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher"
    ]
  }

}