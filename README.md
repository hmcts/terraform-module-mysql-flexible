# terraform-module-mysql-flexible

Terraform module for [MySQL Flexible Server](https://learn.microsoft.com/en-gb/azure/mysql/flexible-server/overview).

## Example

```hcl
module "mysql" {
  source = "../"
  env    = var.env

  product   = "platops"
  component = "example"

  common_tags = module.common_tags.common_tags

  mysql_databases = {
    example = {
      charset   = "utf8"
      collation = "utf8_general_ci"
    }
  }
}

# only for use when building from ADO and as a quick example to get valid tags
# if you are building from Jenkins use `var.common_tags` provided by the pipeline
module "common_tags" {
  source = "github.com/hmcts/terraform-module-common-tags?ref=master"

  builtFrom   = "hmcts/terraform-module-mssql"
  environment = var.env
  product     = "sds-platform"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.41.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.7.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.41.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.7.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_mysql_flexible_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_database) | resource |
| [azurerm_mysql_flexible_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) | resource |
| [azurerm_mysql_flexible_server_active_directory_administrator.admin_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_active_directory_administrator) | resource |
| [azurerm_mysql_flexible_server_active_directory_administrator.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_active_directory_administrator) | resource |
| [azurerm_mysql_flexible_server_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_configuration) | resource |
| [azurerm_mysql_flexible_server_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_firewall_rule) | resource |
| [azurerm_resource_group.new](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [random_password.mysql_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azuread_group.admin_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | The number of days to retain backups for. | `number` | `7` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tag to be applied to resources | `map(string)` | n/a | yes |
| <a name="input_component"></a> [component](#input\_component) | https://hmcts.github.io/glossary/#component | `string` | n/a | yes |
| <a name="input_delegated_subnet_id"></a> [delegated\_subnet\_id](#input\_delegated\_subnet\_id) | The ID of the subnet which is delegated to MySQL Flexible Server. | `string` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment value | `string` | n/a | yes |
| <a name="input_existing_resource_group_name"></a> [existing\_resource\_group\_name](#input\_existing\_resource\_group\_name) | Name of existing resource group to deploy resources into | `string` | `null` | no |
| <a name="input_high_availability"></a> [high\_availability](#input\_high\_availability) | Overrides the automatic selection of high availability mode for the MySQL Flexible Server. Generally you shouldn't set this yourself. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Target Azure location to deploy the resource | `string` | `"UK South"` | no |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The minimum TLS version. | `string` | `"1.2"` | no |
| <a name="input_mysql_admin_password"></a> [mysql\_admin\_password](#input\_mysql\_admin\_password) | The password of the admin account, if a value is not provided one will be generated. | `string` | `null` | no |
| <a name="input_mysql_admin_username"></a> [mysql\_admin\_username](#input\_mysql\_admin\_username) | The username of the admin account, default is 'sqladmin'. | `string` | `"sqladmin"` | no |
| <a name="input_mysql_databases"></a> [mysql\_databases](#input\_mysql\_databases) | Databases for the MySQL instance. | `map(object({ collation : optional(string, "utf8_general_ci"), charset : optional(string, "utf8") }))` | n/a | yes |
| <a name="input_mysql_firewall_rules"></a> [mysql\_firewall\_rules](#input\_mysql\_firewall\_rules) | MySQL firewall rules | `map(object({ start_ip_address : string, end_ip_address : string }))` | `{}` | no |
| <a name="input_mysql_server_configuration"></a> [mysql\_server\_configuration](#input\_mysql\_server\_configuration) | MySQL server configuration. | `map(string)` | `{}` | no |
| <a name="input_mysql_version"></a> [mysql\_version](#input\_mysql\_version) | The version of MySQL to use. | `string` | `"8.0.21"` | no |
| <a name="input_name"></a> [name](#input\_name) | The default name will be product+component+env, you can override the product+component part by setting this | `string` | `null` | no |
| <a name="input_product"></a> [product](#input\_product) | https://hmcts.github.io/glossary/#product | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for MSSQL server. | `bool` | `false` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU to deploy MySQL Flexible server with. | `string` | `"GP_Standard_D2ds_v4"` | no |
| <a name="input_storage_auto_grow"></a> [storage\_auto\_grow](#input\_storage\_auto\_grow) | Should the storage size auto grow? | `bool` | `true` | no |
| <a name="input_storage_io_scaling_enabled"></a> [storage\_io\_scaling\_enabled](#input\_storage\_io\_scaling\_enabled) | Should storage IO scaling be enabled? | `bool` | `false` | no |
| <a name="input_storage_size_gb"></a> [storage\_size\_gb](#input\_storage\_size\_gb) | The size of the storage in GB. | `number` | `20` | no |
| <a name="input_user_assigned_identity_id"></a> [user\_assigned\_identity\_id](#input\_user\_assigned\_identity\_id) | The ID of the user assigned managed identity to assign to MSSQL server. This should have the correct permisisons to read users, groups and service principals. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | n/a |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | n/a |
| <a name="output_password"></a> [password](#output\_password) | n/a |
| <a name="output_resource_group_location"></a> [resource\_group\_location](#output\_resource\_group\_location) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_username"></a> [username](#output\_username) | n/a |
<!-- END_TF_DOCS -->

## Contributing

We use pre-commit hooks for validating the terraform format and maintaining the documentation automatically.
Install it with:

```shell
$ brew install pre-commit terraform-docs
$ pre-commit install
```

If you add a new hook make sure to run it against all files:
```shell
$ pre-commit run --all-files
```
