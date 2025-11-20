resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_container_registry" "main" {
  name                = "${var.prefix}acr${random_integer.suffix.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true
  tags                = var.tags
}
