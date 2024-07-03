// modules/app_service/main.tf

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "app-${random_id.app_service.hex}"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "windows"
  reserved            = true

  sku {
    tier     = "Standard"
    size     = "S1"
    capacity = 1
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "app-${random_id.app_service.hex}"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
  site_config {
    dotnet_framework_version = "v4.0"
  }
  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_app_service_plan.app_service_plan]

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = "@Microsoft.KeyVault(SecretUri=${var.key_vault_uri}/secrets/sqlServer)"
  }
}