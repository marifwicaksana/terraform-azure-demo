output "vm_image" {
  value = data.azurerm_platform_image.image.id
}

output "vm_public_ip_addr" {
  value = azurerm_public_ip.public_ip.ip_address
}