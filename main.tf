terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.31.0"
    }
  }
}

provider "azurerm" {
}

resource "azurerm_resource_group" "rg" {
  name = "${var.project_name}-rg"
  location = var.region
}

resource "azurerm_virtual_network" "network" {
  name = "${var.project_name}-net"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name = "${var.project_name}-subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name = "${var.project_name}-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location

  ip_configuration {
    name = "${var.project_name}-ip-config"
    subnet_id = 
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name = "${var.project_name}-vm"
  vm_size = var.vm_size
  location = azurerm_resource_group.rg.location
  network_interface_ids = []
  resource_group_name = azurerm_resource_group.rg.name

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04_lts"
    version = "latest"
  }

  storage_os_disk {
    name = "${var.project_name}-vm-disk1"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = "${var.project_name}-vm"
    admin_username = "admin"
    admin_password = "P@ssw0rd!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    project = var.project_name
  }
}
