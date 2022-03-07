terraform {
  backend "azurerm" {
    resource_group_name  = "dev-ops-rg"
    storage_account_name = "rfprodtf"
    container_name       = "core-tf-state"
    key                  = "core.rf.tfstate"
  }

  required_providers {
    azurerm = {
        source = "hashicorp/azurerm",
        version = "2.98.0"
    }
  }

  required_version = ">= 0.14"
}