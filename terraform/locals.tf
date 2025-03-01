locals {
  resource_group_name    = "rg-geo-location-config-${var.environment}-${var.location}-${var.instance}"
  app_configuration_name = "appcs-geo-location-${var.environment}-${var.location}-${var.instance}"
}

locals {
  json_files = [for f in fileset("environments", "*.json") : jsondecode(file("environments/${f}"))]

  environments = [for content in local.json_files : {
    name = content.name,
    keys = [for key in lookup(content, "keys", []) : {
      key   = key.key,
      label = lookup(key, "label", ""),
      value = lookup(key, "value", "")
    }]
  }]

  environment_keys = flatten([
    for environment in local.environments : [
      for key in environment.keys : {
        key         = format("%s-%s", environment.name, key.key)
        environment = environment.name
        key_name    = key.key
        label       = key.label
        value       = key.value
      }
    ]
  ])
}
