// modules/key_vault/main.tf

resource "azurerm_key_vault" "key_vault" {
  name                = "kv-${random_id.key_vault.hex}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.app_service_principal_id
    secret_permissions = [
      "get"
    ]
  }
}
