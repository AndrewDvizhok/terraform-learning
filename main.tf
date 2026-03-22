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
  for_each   = toset(["first", "second", "third"])
  source     = "git::https://github.com/AndrewDvizhok/terraform-learning.git?ref=vnet"
  vnet_name  = "my-tf-vnet-${each.key}"
  location   = module.rg.rg_location
  rgn        = module.rg.rg_name
  depends_on = [module.rg]
 
}

module "vnic" {
  source     = "git::https://github.com/AndrewDvizhok/terraform-learning.git?ref=vnic"
  name       = "my-tf-vnic"
  rgn        = module.rg.rg_name
  subnet_id = module.vnet["first"].vnet_id
  depends_on = [module.rg]
}