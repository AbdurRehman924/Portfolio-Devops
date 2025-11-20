resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_key_vault" "main" {
  name                = "${var.prefix}-kv-${random_integer.suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"
  
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id
    
    secret_permissions = [
      "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"
    ]
  }
  
  tags = var.tags
}
