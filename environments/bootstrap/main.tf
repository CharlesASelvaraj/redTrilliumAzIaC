provider "azurerm" {
  features {}
}

module "bootstrap" {
  source = "./modules/bootstrap"
}

data "azurerm_client_config" "current" {}