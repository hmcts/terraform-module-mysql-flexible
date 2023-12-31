module "mysql" {
  source = "../"
  env    = var.env

  product   = "platops"
  component = "example"

  common_tags                  = module.common_tags.common_tags

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
