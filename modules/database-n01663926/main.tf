resource "azurerm_postgresql_server" "database_instance" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  administrator_login = var.admin_username
  administrator_login_password = var.admin_password
  sku_name            = var.sku_name
  version             = var.postgresql_version
  storage_mb = var.storage_mb

  backup_retention_days        = var.backup_retention_days
  ssl_enforcement_enabled      = var.ssl_enforcement_enabled


}


