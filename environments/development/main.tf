provider "azurerm" {
  features {}
}

module "log_analytics" {
  source = "./modules/log_analytics"

  location = var.location
}

module "sql_database" {
  source = "./modules/sql_database"

  admin_user_name = var.admin_user_name
  admin_password  = var.admin_password
  location        = var.location
  log_analytics_workspace_id = module.log_analytics.workspace_id
}

module "key_vault" {
  source = "./modules/key_vault"

  location            = var.location
  app_service_name    = module.app_service.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  log_analytics_workspace_id = module.log_analytics.workspace_id
}

module "app_service" {
  source = "./modules/app_service"

  location = var.location
  key_vault_uri = module.key_vault.uri
  log_analytics_workspace_id = module.log_analytics.workspace_id
}

module "alerts" {
  source = "./modules/alerts"

  location                = var.location
  email_address           = var.email_address
  app_service_name        = module.app_service.name
  app_service_farm_name   = module.app_service.farm_name
  app_service_slots_names = module.app_service.slots_names
}

data "azurerm_client_config" "current" {}