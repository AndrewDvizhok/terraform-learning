terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.65"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

resource "azurerm_resource_group" "default" {
  name     = "tf-rg-spaincentral"
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
  resource_group_name      = azurerm_resource_group.default.name
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