package terraform.naming

import rego.v1

# Resource naming conventions
deny contains msg if {
    resource := input.resource_changes[_]
    resource.type == "azurerm_resource_group"
    
    not regex.match("^[a-z0-9-]+rg$", resource.change.after.name)
    
    msg := sprintf("Resource group '%s' must end with '-rg'", [resource.change.after.name])
}

deny contains msg if {
    resource := input.resource_changes[_]
    resource.type == "azurerm_kubernetes_cluster"
    
    not regex.match("^[a-z0-9-]+-aks$", resource.change.after.name)
    
    msg := sprintf("AKS cluster '%s' must end with '-aks'", [resource.change.after.name])
}

deny contains msg if {
    resource := input.resource_changes[_]
    resource.type == "azurerm_container_registry"
    
    not regex.match("^[a-z0-9]+acr[0-9]+$", resource.change.after.name)
    
    msg := sprintf("Container registry '%s' must follow pattern: [prefix]acr[number]", [resource.change.after.name])
}
