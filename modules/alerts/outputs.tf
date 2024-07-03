output "name" {
  value = azurerm_app_service.app_service.name
}

output "farm_name" {
  value = azurerm_app_service_plan.app_service_plan.name
}

output "slots_names" {
  value = ["Staging", "LastKnownGood"]
}
