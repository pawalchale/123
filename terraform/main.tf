terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.4.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-static-${var.env}"
  location = var.location
}

resource "azurerm_storage_account" "sa" {
  name                     = "staticsite${var.env}123" # globally unique
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"
  }
}

resource "azurerm_storage_container" "icon_container" {
  name                  = "icons"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "container"
}

resource "azurerm_storage_blob" "greeting_icon" {
  name                   = "icon.png"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.icon_container.name
  type                   = "Block"
  source                 = "${path.module}/../src/icon.png"
}
