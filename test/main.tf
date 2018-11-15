#Run an Ansible playbook from within Terraform
resource "null_resource" "run-ansible" {

  provisioner "local-exec" {
    command = "echo 'Hello World'"
  }
}
