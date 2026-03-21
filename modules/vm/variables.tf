variable "name"{
    type = string
}

variable "location" {
  
}

variable "rg" {
  
}

variable "vm_size" {
  default = "Standard_B1s"
}

variable "admin"{
    default = "azureuser"
}

variable "pass" {
  type = string
  sensitive = true
}

variable "subnet_id" {
  
}