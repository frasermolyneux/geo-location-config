resource "azurerm_app_configuration" "app_configuration" {
  name = local.app_configuration_name

  sku = "free"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  #checkov:skip=CKV_AZURE_187: Ensure App configuration purge protection is enabled :: Not compatible with free sku.
  purge_protection_enabled             = false
  data_plane_proxy_authentication_mode = "Pass-through"

  local_auth_enabled = false

  tags = var.tags

  #checkov:skip=CKV_AZURE_186: Ensure App configuration encryption block is set :: CMK/encryption is not being used.
  #checkov:skip=CKV_AZURE_188: Ensure App configuration Sku is standard :: Using free tier for cost management.
}
