variable "vnet_name" {}
variable "rgn" {}
variable "location" {
  default = "eastus"
}
variable "space" {
  default = ["10.0.0.0/16"]
}

resource "azurerm_virtual_network" "default" {
  name           = var.vnet_name
  location       = var.location
  resource_group_name = var.rgn
  address_space   = var.space
}

output "vnet_id" {
  value = azurerm_virtual_network.default.id
}