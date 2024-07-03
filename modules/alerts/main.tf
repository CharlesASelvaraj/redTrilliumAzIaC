// modules/alerts/main.tf

resource "azurerm_monitor_action_group" "email_alert" {
  name                = "email-alert"
  resource_group_name = var.resource_group_name
  short_name          = "email-alert"

  email_receiver {
    name                    = "emailAction"
    email_address           = var.email_address
    use_common_alert_schema = false
  }
}

resource "azurerm_monitor_metric_alert" "http_5xx_alert" {
  name                = "Http5xx-${var.app_service_name}"
  resource_group_name = var.resource_group_name
  description         = "${var.app_service_name} has some server errors, status code 5xx."
  severity            = 3
  enabled             = true
  frequency           = "PT1M"
  window_size         = "PT1M"
  scopes              = [azurerm_app_service.app_service.id]

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 0
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_alert.id
  }
}

resource "azurerm_monitor_metric_alert" "http_403_alert" {
  name                = "Http403-${var.app_service_name}"
  resource_group_name = var.resource_group_name
  description         = "${var.app_service_name} has some requests that are forbidden, status code 403."
  severity            = 3
  enabled             = true
  frequency           = "PT1M"
  window_size         = "PT1M"
  scopes              = [azurerm_app_service.app_service.id]

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http403"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 0
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_alert.id
  }
}

resource "azurerm_monitor_metric_alert" "cpu_high_alert" {
  name                = "CPUHigh-${var.app_service_farm_name}"
  resource_group_name = var.resource_group_name
  description         = "The average CPU is high across all the instances of ${var.app_service_farm_name}"
  severity            = 3
  enabled             = true
  frequency           = "PT1M"
  window_size         = "PT1M"
  scopes              = [azurerm_app_service.app_service.id]

  criteria {
    metric_namespace = "Microsoft.Web/serverfarms"
    metric_name      = "CpuPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_alert.id
  }
}

resource "azurerm_monitor_metric_alert" "http_queue_alert" {
  name                = "HttpQueue-${var.app_service_farm_name}"
  resource_group_name = var.resource_group_name
  description         = "The HTTP queue for the instances of ${var.app_service_farm_name} has a large number of pending requests."
  severity            = 3
  enabled             = true
  frequency           = "PT1M"
  window_size         = "PT1M"
  scopes              = [azurerm_app_service.app_service.id]

  criteria {
    metric_namespace = "Microsoft.Web/serverfarms"
    metric_name      = "HttpQueueLength"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 100
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_alert.id
  }
}
