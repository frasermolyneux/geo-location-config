environment = "prd"
location    = "uksouth"
instance    = "01"

subscription_id = "d3b204ab-7c2b-47f7-8d5a-de19e85591e7"

log_analytics_subscription_id     = "d68448b0-9947-46d7-8771-baa331a3063a"
log_analytics_resource_group_name = "rg-platform-logging-prd-uksouth-01"
log_analytics_workspace_name      = "log-platform-prd-uksouth-01"

app_configs = ["prd", "shared"]

tags = {
  Environment = "prd",
  Workload    = "geo-location-config",
  DeployedBy  = "GitHub-Terraform",
  Git         = "https://github.com/frasermolyneux/geo-location-config"
}
