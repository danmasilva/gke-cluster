output "rancher_server_address" {
  value = google_compute_address.rancher_server_address.address
}

output "ssh_public_key_openssh_filename" {
  value = local_file.ssh_public_key_openssh.filename
}

output "ssh_public_key_openssh" {
  value = local_file.ssh_public_key_openssh.content
}

output "ssh_private_key_openssh" {
  value = local_file.ssh_private_key_pem.sensitive_content
}

output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "network_name" {
  value = google_compute_network.vpc.name
}

output "subnetwork_name" {
  value = google_compute_subnetwork.subnet.name
}