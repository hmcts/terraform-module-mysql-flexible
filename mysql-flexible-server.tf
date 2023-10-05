resource "random_password" "mysql_password" {
  count            = var.mysql_admin_password == null ? 1 : 0
  length           = 32
  special          = true
  override_special = "#$%&@()_[]{}<>:?"
  min_upper        = 4
  min_lower        = 4
  min_numeric      = 4
}

resource "azurerm_mysql_flexible_server" "this" {
  name                   = local.server_name
  resource_group_name    = local.resource_group
  location               = local.resource_group_location
  administrator_login    = var.mysql_admin_username
  administrator_password = local.admin_password
  backup_retention_days  = var.backup_retention_days
  version                = var.mysql_version
  delegated_subnet_id    = var.delegated_subnet_id
  private_dns_zone_id    = "/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/core-infra-intsvc-rg/providers/Microsoft.Network/privateDnsZones/privatelink.mysql.database.azure.com"
  sku_name               = var.sku_name
  tags                   = var.common_tags

  storage {
    auto_grow_enabled  = var.storage_auto_grow
    size_gb            = var.storage_size_gb
    io_scaling_enabled = var.storage_io_scaling_enabled
  }

  dynamic "identity" {
    for_each = var.user_assigned_identity_id == null ? [] : [var.user_assigned_identity_id]
    content {
      type         = "UserAssigned"
      identity_ids = [identity.value]
    }
  }

  dynamic "high_availability" {
    for_each = local.high_availability != false ? [1] : []
    content {
      mode = "ZoneRedundant"
    }
  }

  lifecycle {
    ignore_changes = [
      zone,
      high_availability.0.standby_availability_zone
    ]
  }
}

resource "azurerm_mysql_flexible_server_configuration" "this" {
  for_each            = var.mysql_server_configuration
  name                = each.key
  resource_group_name = local.resource_group
  server_name         = azurerm_mysql_flexible_server.this.name
  value               = each.value
}

resource "azurerm_mysql_flexible_server_active_directory_administrator" "admin_group" {
  count       = var.user_assigned_identity_id != null ? 1 : 0
  server_id   = azurerm_mysql_flexible_server.this.id
  identity_id = var.user_assigned_identity_id
  login       = local.admin_group
  object_id   = data.azuread_group.admin_group.object_id
  tenant_id   = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_mysql_flexible_server_active_directory_administrator" "current" {
  count       = var.user_assigned_identity_id != null ? 1 : 0
  server_id   = azurerm_mysql_flexible_server.this.id
  identity_id = var.user_assigned_identity_id
  login       = local.admin_group
  object_id   = data.azurerm_client_config.current.object_id
  tenant_id   = data.azurerm_client_config.current.tenant_id
}
