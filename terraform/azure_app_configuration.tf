resource "azurerm_app_configuration" "app_configuration" {
  name = local.app_configuration_name

  sku = "free"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}
