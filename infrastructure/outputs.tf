output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.resource_group.name
}

output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value       = module.aks.cluster_name
}

output "acr_login_server" {
  description = "Login server for the container registry"
  value       = module.container_registry.login_server
}

output "acr_name" {
  description = "Name of the container registry"
  value       = module.container_registry.name
}

output "key_vault_name" {
  description = "Name of the key vault"
  value       = module.key_vault.name
}

output "aks_fqdn" {
  description = "FQDN of the AKS cluster"
  value       = module.aks.fqdn
}
