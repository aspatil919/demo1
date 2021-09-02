





terraform {
    backend "azurerm" {
        resource_group_name = "demo001"
        storage_account_name = "stroagev100"
        container_name = "democon"
        key = "mainfile1.tfstate"
    }
}

resource "azurerm_resource_group" "RG1" {
    name     = var.var_RG_name
    location = var.var_location
}

resource "azurerm_storage_account" "STG" {
   name = var.var_Storage_name
   resource_group_name = azurerm_resource_group.RG.name
   location = var.var_location
   account_tier = var.var_account_tier
   account_replication_type = var.var_account_replication_type
 }
resource "azurerm_storage_container" "storage_container" {
  name                  = var.var_storage_containername
  storage_account_name  = azurerm_storage_account.var_storage_name
  container_access_type = "private"
}


