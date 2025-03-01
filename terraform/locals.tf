locals {
  resource_group_name    = "rg-geo-location-config-${var.environment}-${var.location}-${var.instance}"
  app_configuration_name = "appcs-geo-location-${var.environment}-${var.location}-${var.instance}"
}

locals {
  json_files = [for config in var.app_configs : jsondecode(file("app_configs/${config}.json"))]

  configs = [for content in local.json_files : {
    name = content.environment,
    keys = [for key in lookup(content, "keys", []) : {
      key   = key.key,
      label = lookup(key, "label", ""),
      value = lookup(key, "value", "")
    }]
  }]

  config_keys = flatten([
    for config in local.configs : [
      for key in config.keys : {
        key      = format("%s-%s", config.name, key.key)
        config   = config.name
        key_name = key.key
        label    = key.label
        value    = key.value
      }
    ]
  ])
}
