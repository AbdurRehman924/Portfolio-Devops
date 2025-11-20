output "id" {
  description = "ID of the key vault"
  value       = azurerm_key_vault.main.id
}

output "name" {
  description = "Name of the key vault"
  value       = azurerm_key_vault.main.name
}
