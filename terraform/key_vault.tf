resource "random_id" "config_id" {
  for_each = { for each in local.configs : each.prefix => each }

  byte_length = 6
}

resource "azurerm_key_vault" "config_kv" {
  for_each = { for each in local.configs : each.prefix => each }

  name = "kv-${random_id.config_id[each.value.prefix].hex}-${var.location}"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tenant_id = data.azurerm_client_config.current.tenant_id

  tags = merge(var.tags, {
    config = each.value.prefix
  })

  soft_delete_retention_days = 90
  purge_protection_enabled   = true
  enable_rbac_authorization  = true

  sku_name = "standard"

  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow"
  }

  #checkov:skip=CKV2_AZURE_32: Ensure private endpoint is configured to key vault :: Free/consumption SKUs are being used so cannot use private endpoints.
  #checkov:skip=CKV_AZURE_189: Ensure that Azure Key Vault disables public network access :: Free/consumption SKUs are being used so public access is required.
  #checkov:skip=CKV_AZURE_109: Ensure that key vault allows firewall rules settings :: Free/consumption SKUs are being used so public access is required.
}
