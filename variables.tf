variable "project_name" {
  description = "Project name"
  default = "simple-vm"
  type = string
}

variable "region" {
  description = "Azure region to deploy the resources."
  default = "	East US"
  type = string
}

variable "vm_size" {
  default = "Standard_DS1_v2"
  type = string
}