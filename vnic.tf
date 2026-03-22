variable "name" {}
variable "location" {
  default = "eastus"
}
variable "rgn" {}
variable "subnet_id" {}

resource "azurerm_network_interface" "default" {
  name                = var.name
  resource_group_name = var.rgn
  location            = var.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dyncamic"
  }

  tags = {
    env = "test"
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
    ignore_changes        = [tags]
  }

}

output "vnic_id" {
  value = azurerm_network_interface.default.id
}