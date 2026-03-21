output "vm_id" {
  value = azurerm_linux_virtual_machine.default.id
}

output "private_ip" {
  value = azurerm_network_interface.default.private_ip_address
}