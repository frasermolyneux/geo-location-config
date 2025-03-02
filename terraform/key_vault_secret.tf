resource "azurerm_key_vault_secret" "config_secret" {
  for_each = { for each in local.config_secret_keys : each.key => each }

  name         = "${each.value.prefix}-${each.value.key_name}"
  value        = "placeholder"
  key_vault_id = azurerm_key_vault.config_kv[each.value.prefix].id

  lifecycle {
    ignore_changes = [value]
  }
}
