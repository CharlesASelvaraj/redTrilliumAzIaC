// modules/log_analytics/main.tf

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "la-${random_id.workspace.hex}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
}