terraform {
  required_version = "~>1.14"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.66"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tf-rg-spaincentral"
    storage_account_name = "andrewdvizhoktflearnsc"
    container_name       = "state"
    key                  = "test.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

variable "rgn" {
  default = "tf-rg-spaincentral"
}

resource "azurerm_resource_group" "default" {
  name     = var.rgn
  location = "spaincentral"
  tags = {
    env = "test"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_storage_account" "tf" {
  name                     = "andrewdvizhoktflearnsc"
  resource_group_name      = var.rgn
  location                 = azurerm_resource_group.default.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  lifecycle {
    prevent_destroy = true
  }

}

resource "azurerm_storage_container" "tf" {
  name                  = "state"
  storage_account_id    = azurerm_storage_account.tf.id
  container_access_type = "private"
  lifecycle {
    prevent_destroy = true
  }
}

data "azurerm_resource_group" "free"{
  name = "free"
}

output "free_location"{
  value = data.azurerm_resource_group.free.location
}