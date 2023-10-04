data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}

locals {
  name                    = var.name != null ? var.name : "${var.product}-${var.component}"
  server_name             = "${local.name}-${var.env}"
  is_prod                 = length(regexall(".*(prod).*", var.env)) > 0
  admin_group             = local.is_prod ? "DTS Platform Operations SC" : "DTS Platform Operations"
  admin_password          = var.mysql_admin_password == null ? random_password.mysql_password[0].result : var.mysql_admin_password
  resource_group          = var.existing_resource_group_name == null ? azurerm_resource_group.new[0].name : var.existing_resource_group_name
  resource_group_location = var.existing_resource_group_name == null ? azurerm_resource_group.new[0].location : var.location

  high_availability_environments = ["ptl", "perftest", "stg", "aat", "prod"]
  high_availability              = var.high_availability == true || contains(local.high_availability_environments, var.env)
}

data "azuread_group" "admin_group" {
  display_name     = local.admin_group
  security_enabled = true
}
