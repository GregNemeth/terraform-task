// Outputs that you want to display after you run terraform apply
output "public_vm_private_ip" {
  value = module.virtual_machine.public_vm_private_ip
}
output "private_vm_private_ip" {
  value = module.private_virtual_machine.private_vm_private_ip
}
