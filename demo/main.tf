terraform {
  backend "local" {
    path = "C:/Users/terraform.tfstate"
  }
}





#terraform {
 #   backend "azurerm" {
  #      resource_group_name = "demo001"
   #     storage_account_name = "storagev100"
    #    container_name = "democon"
     #   key = "main.tfstate"
    #}
#}

resource "azurerm_resource_group" "RG" {
    name     = var.var_RG_name
    location = var.var_location
}

provider "azurerm" {
  client_id         = var.client_id
  client_secret     = var.client_secret
  tenant_id         = var.tenant_id
  subscription_id   = var.subscription_id
}

resource "azurerm_databricks_workspace" "this" {
  location                      = "centralus"
  name                          = "my-workspace-name"
  resource_group_name           = var.resource_group
  sku                           = "premium"}
provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.this.id
  azure_client_id             = var.client_id
  azure_client_secret         = var.client_secret
  azure_tenant_id             = var.tenant_id
}resource "databricks_user" "my-user" {user_name = "test-user@databricks.com"}





#resource "azurerm_storage_account" "STG" {
 #  name = var.var_Storage_name
  # resource_group_name = azurerm_resource_group.RG.name
   #location = var.var_location
   #account_tier = var.var_account_tier
   #account_replication_type = var.var_account_replication_type
 
#}
#resource "azurerm_storage_container" "storage_container" {
#  name                  = var.var_storage_containername
 # storage_account_name  = azurerm_storage_account.STG.name
  #container_access_type = "private"
#}

#resource "azurerm_data_factory" "data_factory"{
#name ="demodatafactoryprod1"
#location = var.var_location
#resource_group_name = azurerm_resource_group.RG.name
#}

#resource "azurerm_data_lake_store" "data_lake" {
#name ="demodatalakeprod"
#resource_group_name =azurerm_resource_group.RG.name
#location = var.var_location

#}


