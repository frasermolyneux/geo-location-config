locals {
  resource_group_name    = "rg-geo-location-config-${var.environment}-${var.location}-${var.instance}"
  app_configuration_name = "appcs-geo-location-${var.environment}-${var.location}-${var.instance}"
}
