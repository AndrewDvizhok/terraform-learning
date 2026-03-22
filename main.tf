terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.65"
    }
  }
}

provider "azurerm" {
  features {}
}

module "rg" {
  source = "./modules/rg"
}

module "vnet" {
for_each = toset(["first", "second", "third"])
  source     = "git::https://github.com/AndrewDvizhok/terraform-learning.git?ref=vnet"
  vnet_name  = "my-tf-vnet-${each.key}"
  location   = module.rg.rg_location
  rgn        = module.rg.rg_name
  depends_on = [module.rg]
  
}