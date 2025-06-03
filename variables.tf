variable "subscription" {
  description = "Azure subscription ID"
  type        = string
}

variable "project_name" {
  description = "Project name"
  default     = "simple-vm"
  type        = string
}

variable "region" {
  description = "Azure region to deploy the resources."
  default     = "Central US"
  type        = string
}

variable "vm_size" {
  default = "Standard_B2s"
  type    = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}