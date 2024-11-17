data "external" "new_ssh_key_pair_path"{
  program = ["bash", "create_keypair.sh", var.ssh_key_name]
}

output "ssh_key_path" {
  value = data.external.new_ssh_key_pair_path.result
}