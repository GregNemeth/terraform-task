// Output the subnet IDs for the VMs

output "public_interface_id" {
    value = azurerm_network_interface.public.id
}

output "private_interface_id" {
    value = azurerm_network_interface.private.id
}
