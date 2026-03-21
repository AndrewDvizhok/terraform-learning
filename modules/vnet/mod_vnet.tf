variable "vnet_location"{
default = "eastus"
}

variable "vnet_name"{
 type = string
}

variable "rgn"{}

resource "azurerm_virtual_network" "default" {
	name = var.vnet_name
	location = var.vnet_location
	resource_group_name = var.rgn
	address_space = ["10.0.0.0/16"]
	
	tags = {
		env = "test"
	}
}

output "vnet_id"{
	value = azurerm_virtual_network.default.id
}