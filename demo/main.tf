





terraform {
    backend "azurerm" {
        resource_group_name = "demo001"
        storage_account_name = "storagev100"
        container_name = "democon"
        key = "main.tfstate"
    }
}

resource "azurerm_resource_group" "RG" {
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
  storage_account_name  = azurerm_storage_account.STG.name
  container_access_type = "private"
}

resource "azurerm_data_factory" "data_factory"{
name ="demodatafactoryprod"
location = var.var_location
resource_group_name = azurerm_resource_group.RG.name
}

resource "azurerm_data_lake_store" "data_lake" {
name ="demodatalakeprod"
resource_group_name =azurerm_resource_group.RG.name
location = var.var_location

}


