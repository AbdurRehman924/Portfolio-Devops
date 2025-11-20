terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "rg-portfolio-${var.environment}"
  location = var.location

  tags = {
    Environment = var.environment
    Project     = "portfolio-devops"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "acrportfolio${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    Environment = var.environment
    Project     = "portfolio-devops"
  }
}
