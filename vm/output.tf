// Output the VM IPs and admin user
output "private_vm_private_ip" {
    value = azurerm_linux_virtual_machine.private.private_ip_address
}

output "private_vm_admin" {
    value = azurerm_linux_virtual_machine.private.admin_username
}

output "public_vm_private_ip" {
    value = azurerm_linux_virtual_machine.public.private_ip_address
}

output "public_vm_admin" {
    value = azurerm_linux_virtual_machine.public.admin_username
}


