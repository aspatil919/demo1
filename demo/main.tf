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
  client_id         = var.var_client_id
  client_secret     = var.var_client_secret
  tenant_id         = var.var_tenant_id
  subscription_id   = var.var_subscription_id
}

resource "azurerm_databricks_workspace" "this" {
  location                      = "centralus"
  name                          = "my-workspace-name"
  resource_group_name           = var.var_RG_name
  sku                           = "premium"}
provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.this.id
  azure_client_id             = var.client_id
  azure_client_secret         = var.client_secret
  azure_tenant_id             = var.tenant_id
}resource "databricks_user" "my-user" {user_name = "test-user@databricks.com"}




provider "databricks" {
}

data "databricks_current_user" "me" {}
data "databricks_spark_version" "latest" {}
data "databricks_node_type" "smallest" {
  local_disk = true
}

resource "databricks_notebook" "this" {
  path     = "${data.databricks_current_user.me.home}/Terraform"
  language = "PYTHON"
  content_base64 = base64encode(<<-EOT
    # created from ${abspath(path.module)}
    display(spark.range(10))
    EOT
  )
}

resource "databricks_job" "this" {
  name = "Terraform Demo (${data.databricks_current_user.me.alphanumeric})"

  new_cluster {
    num_workers   = 1
    spark_version = data.databricks_spark_version.latest.id
    node_type_id  = data.databricks_node_type.smallest.id
  }

  notebook_task {
    notebook_path = databricks_notebook.this.path
  }

  email_notifications {}
}

output "notebook_url" {
  value = databricks_notebook.this.url
}

output "job_url" {
  value = databricks_job.this.url
}



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


