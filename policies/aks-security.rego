package terraform.aks

import rego.v1

# Deny AKS clusters with public API server access
deny contains msg if {
    resource := input.resource_changes[_]
    resource.type == "azurerm_kubernetes_cluster"
    
    # Check if api_server_access_profile is missing or allows all IPs
    not resource.change.after.api_server_access_profile
    
    msg := sprintf("AKS cluster '%s' must have restricted API server access", [resource.name])
}

deny contains msg if {
    resource := input.resource_changes[_]
    resource.type == "azurerm_kubernetes_cluster"
    
    # Check if authorized_ip_ranges includes 0.0.0.0/0
    "0.0.0.0/0" in resource.change.after.api_server_access_profile[0].authorized_ip_ranges
    
    msg := sprintf("AKS cluster '%s' should not allow public access (0.0.0.0/0)", [resource.name])
}

# Require tags on all resources
deny contains msg if {
    resource := input.resource_changes[_]
    resource.type in ["azurerm_resource_group", "azurerm_kubernetes_cluster", "azurerm_container_registry"]
    
    not resource.change.after.tags.Environment
    
    msg := sprintf("Resource '%s' of type '%s' must have 'Environment' tag", [resource.name, resource.type])
}

deny contains msg if {
    resource := input.resource_changes[_]
    resource.type in ["azurerm_resource_group", "azurerm_kubernetes_cluster", "azurerm_container_registry"]
    
    not resource.change.after.tags.Project
    
    msg := sprintf("Resource '%s' of type '%s' must have 'Project' tag", [resource.name, resource.type])
}
