locals {
  resource_group_name  = vars.resource_group_name 
  storage_account_name = vars.globaltfstate
  container_names      = vars.container_names
  location             = vars.location
  terraform_tfstate_key   = vars.terraform_tfstate_key
}

# Resource group
resource "azurerm_resource_group" "global_tfstate_rg" {
  name     = local.resource_group_name
  location = local.location
}

# Storage account
resource "azurerm_storage_account" "storage" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.global_tfstate_rg.name
  location                 = azurerm_resource_group.global_tfstate_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  lifecycle {
    prevent_destroy = true
  }
}

# Storage container
resource "azurerm_storage_container" "container" {

  for_each = toset(local.container_names)
  name                  = each.value
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
} 

# terraform {
#   backend "azurerm" {
#     resource_group_name  = local.resource_group_name
#     storage_account_name = local.storage_account_name
#     container_name       = local.container_name
#     key                  = "corporate.terraform.tfstate"
#   }
# }