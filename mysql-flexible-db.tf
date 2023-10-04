resource "azurerm_mysql_flexible_database" "this" {
  for_each            = var.mysql_databases
  name                = each.key
  resource_group_name = local.resource_group
  server_name         = azurerm_mysql_flexible_server.this.name
  charset             = each.value.charset
  collation           = each.value.collation
}
