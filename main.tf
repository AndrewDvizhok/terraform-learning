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
}

module "stor_acc" {
  source = "git::https://github.com/AndrewDvizhok/terraform-learning.git?ref=stor_acc"
  rgn    = azurerm_resource_group.default.name
}