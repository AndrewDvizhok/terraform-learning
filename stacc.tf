variable "rgn" {}
variable "location" {
  default = "spaincentral"
}
variable "name" {
  default = "andrewdvizhoktflearnsc"
}
resource "azurerm_storage_account" "tf" {
  name                     = var.name
  resource_group_name      = var.rgn
  location                 = "spaincentral"
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "tf" {
  name                  = "state"
  storage_account_name  = azurerm_storage_account.tf.name
  container_access_type = "private"
}

output "container_name" {
  value = azurerm_storage_container.tf.name
}