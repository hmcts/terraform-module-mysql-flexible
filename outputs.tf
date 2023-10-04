output "resource_group_name" {
  value = local.resource_group
}

output "resource_group_location" {
  value = local.resource_group_location
}

output "username" {
  value = var.mysql_admin_username
}

output "password" {
  value = local.admin_password
}

output "fqdn" {
  value = azurerm_mysql_flexible_server.this.fqdn
}

output "instance_id" {
  value = azurerm_mysql_flexible_server.this.id
}
