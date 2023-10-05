resource "azurerm_resource_group" "example" {
  name     = "mysql-flexible-example-sbox"
  location = "uksouth"
  tags     = module.common_tags.common_tags
}

resource "azurerm_virtual_network" "example" {
  name                = "mysql-flexible-example-vnet-sbox"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  tags                = module.common_tags.common_tags
  address_space       = ["10.199.199.0/24"]
}

resource "azurerm_subnet" "example" {
  name                 = "mysql-flexible"
  virtual_network_name = azurerm_virtual_network.example.name
  resource_group_name  = azurerm_resource_group.example.name
  address_prefixes     = ["10.199.199.0/25"]
  delegation {
    name = "mysql-flexible"
    service_delegation {
      name    = "Microsoft.DBforMySQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

data "azurerm_private_dns_zone" "mysql" {
  provider            = azurerm.cftptl
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = "core-infra-intsvc-rg"
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  provider              = azurerm.cftptl
  name                  = "test-link"
  private_dns_zone_name = data.azurerm_private_dns_zone.mysql.name
  virtual_network_id    = azurerm_virtual_network.example.id
  resource_group_name   = data.azurerm_private_dns_zone.mysql.resource_group_name
  tags                  = module.common_tags.common_tags
}

module "mysql" {
  source = "../"
  env    = var.env

  product   = "platops"
  component = "example"

  common_tags                  = module.common_tags.common_tags
  delegated_subnet_id          = azurerm_subnet.example.id
  existing_resource_group_name = azurerm_resource_group.example.name
  private_dns_zone_id          = data.azurerm_private_dns_zone.mysql.id

  depends_on = [azurerm_private_dns_zone_virtual_network_link.example]

  mysql_databases = {
    example = {
      charset   = "utf8mb3"
      collation = "utf8mb3_general_ci"
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
