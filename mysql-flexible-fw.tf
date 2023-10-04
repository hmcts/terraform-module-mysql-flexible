resource "azurerm_mysql_flexible_server_firewall_rule" "this" {
  for_each            = var.mysql_firewall_rules
  name                = each.key
  resource_group_name = local.resource_group
  server_name         = azurerm_mysql_flexible_server.this.name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
}
