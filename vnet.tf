variable "vnet_name" {}
variable "rgn" {}
variable "location" {
  default = "eastus"
}
variable "space" {
  default = ["10.0.0.0/16"]
}

resource "azurerm_virtual_netwrok" "default" {
  name           = var.vnet_name
  location       = var.location
  resource_group = var.rgn
  subnet_space   = var.space
}

output "vnet_id" {
  value = azurerm_virtual_netwrok.default.id
}