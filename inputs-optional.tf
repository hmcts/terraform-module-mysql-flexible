variable "existing_resource_group_name" {
  description = "Name of existing resource group to deploy resources into"
  type        = string
  default     = null
}

variable "location" {
  description = "Target Azure location to deploy the resource"
  type        = string
  default     = "UK South"
}

variable "name" {
  description = "The default name will be product+component+env, you can override the product+component part by setting this"
  type        = string
  default     = null
}

variable "mysql_version" {
  description = "The version of MySQL to use."
  type        = string
  default     = "8.0.21"
}

variable "mysql_admin_username" {
  description = "The username of the admin account, default is 'sqladmin'."
  type        = string
  default     = "sqladmin"
}

variable "mysql_admin_password" {
  description = "The password of the admin account, if a value is not provided one will be generated."
  type        = string
  sensitive   = true
  default     = null
}

variable "minimum_tls_version" {
  description = "The minimum TLS version."
  type        = string
  default     = "1.2"
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for MSSQL server."
  type        = bool
  default     = false
}

variable "user_assigned_identity_id" {
  description = "The ID of the user assigned managed identity to assign to MSSQL server. This should have the correct permisisons to read users, groups and service principals."
  type        = string
  default     = null
}

variable "backup_retention_days" {
  description = "The number of days to retain backups for."
  type        = number
  default     = 7
}

variable "sku_name" {
  description = "The SKU to deploy MySQL Flexible server with."
  type        = string
  default     = "GP_Standard_D2ds_v4"
}

variable "mysql_databases" {
  description = "Databases for the MySQL instance."
  type        = map(object({ collation : optional(string, "utf8_general_ci"), charset : optional(string, "utf8") }))
}

variable "mysql_server_configuration" {
  description = "MySQL server configuration."
  type        = map(string)
  default     = {}
}

variable "storage_size_gb" {
  description = "The size of the storage in GB."
  type        = number
  default     = 20
}

variable "storage_auto_grow" {
  description = "Should the storage size auto grow?"
  type        = bool
  default     = true
}

variable "storage_io_scaling_enabled" {
  description = "Should storage IO scaling be enabled?"
  type        = bool
  default     = false
}

variable "mysql_firewall_rules" {
  description = "MySQL firewall rules"
  type        = map(object({ start_ip_address : string, end_ip_address : string }))
  default     = {}
}

variable "delegated_subnet_id" {
  description = "The ID of the subnet which is delegated to MySQL Flexible Server."
  type        = string
  default     = null
}

variable "high_availability" {
  description = "Overrides the automatic selection of high availability mode for the MySQL Flexible Server. Generally you shouldn't set this yourself."
  type        = bool
  default     = false
}
