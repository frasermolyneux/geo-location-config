resource "azurerm_app_configuration_key" "environment_keys" {
  for_each = { for each in local.config_keys : each.key => each }

  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "${each.value.prefix}-${each.value.key_name}"
  label = each.value.label
  value = each.value.value
}

