package terraform.security

# Deny public AKS clusters
deny[msg] {
    input.resource_changes[_].type == "azurerm_kubernetes_cluster"
    input.resource_changes[_].change.after.api_server_access_profile[_].authorized_ip_ranges == null
    msg := "AKS cluster must not be publicly accessible"
}

# Require tags on resources
deny[msg] {
    input.resource_changes[_].type == "azurerm_resource_group"
    not input.resource_changes[_].change.after.tags.Environment
    msg := "Resource group must have Environment tag"
}
