locals {
  resource_group_name    = "rg-geo-location-config-${var.environment}-${var.location}"
  app_configuration_name = "appcs-geo-location-${var.environment}-${var.location}"
}

locals {
  json_files = [for config in var.app_configs : jsondecode(file("app_configs/${config}.json"))]

  configs = [for content in local.json_files : {
    prefix = content.prefix,
    keys = [for key in lookup(content, "keys", []) : {
      key   = key.key,
      label = lookup(key, "label", ""),
      value = lookup(key, "value", "")
    }]
    secret_keys = [for key in lookup(content, "secret_keys", []) : {
      key   = key.key,
      label = lookup(key, "label", "")
    }]
  }]

  config_keys = flatten([
    for config in local.configs : [
      for key in config.keys : {
        key      = format("%s-%s", config.prefix, key.key)
        prefix   = config.prefix
        key_name = key.key
        label    = key.label
        value    = key.value
      }
    ]
  ])

  config_secret_keys = flatten([
    for config in local.configs : [
      for key in config.secret_keys : {
        key      = format("%s-%s", config.prefix, key.key)
        prefix   = config.prefix
        key_name = key.key
        label    = key.label
      }
    ]
  ])
}
