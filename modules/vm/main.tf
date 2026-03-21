resource "azurerm_network_interface" "default"{
    name = "${var.name}-nic"
    location = var.location
    resource_group_name = var.rg

    ip_configuration{
        name = "default"
        subnet_id = var.subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_linux_virtual_machine" "default" {
    name = "${var.name}-vm"
    location = var.location
    resource_group_name = var.rg
    size = var.vm_size
    admin_username = var.admin
    admin_password = var.pass

    network_interface_ids = [azurerm_network_interface.default.id]

    os_disk{
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "Canonical"
      offer = "ubuntu-24_04-lts"
      sku = "server"
      version = "latest"
    }
}