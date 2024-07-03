// modules/sql_database/main.tf

resource "azurerm_sql_server" "sql_server" {
  name                         = "sql-${random_id.sql_server.hex}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_user_name
  administrator_login_password = var.admin_password
}

resource "azurerm_sql_database" "sql_database" {
  name                = "appdb"
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = azurerm_sql_server.sql_server.name
  edition             = "Standard"
  max_size_gb         = 1
  requested_service_objective_name = "S0"
}

output "sql_server_fully_qualified_domain_name" {
  value = azurerm_sql_server.sql_server.fully_qualified_domain_name
}
