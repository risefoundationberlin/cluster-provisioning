provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "state-rg" {
    name     = "dev-ops-rg"
    location = "Germany West Central"
    tags = {
        environment = "Production"
    }
    lifecycle {
        prevent_destroy = true
    }
}

# Create a Storage Account for the Terraform State File
resource "azurerm_storage_account" "state-sta" {
    depends_on = [azurerm_resource_group.state-rg]
    name = "rfprodtfsa"
    resource_group_name = "dev-ops-rg"
    location = azurerm_resource_group.state-rg.location
    account_kind = "StorageV2"
    account_tier = "Standard"
    access_tier = "Hot"
    account_replication_type = "ZRS"
    enable_https_traffic_only = true
    lifecycle {
        prevent_destroy = true
    }
    tags = {
        environment = "Production"
    }
}

# Create a Storage Container for the Core State File
resource "azurerm_storage_container" "core-container" {
    depends_on = [azurerm_storage_account.state-sta]
    name = "core-tfstate"
    storage_account_name = azurerm_storage_account.state-sta.name
}

resource "azurerm_kubernetes_cluster" "rf-prod" {
    name = "rf-prod"
    location = azurerm_resource_group.state-rg.location
    resource_group_name = azurerm_resource_group.state-rg.name
    dns_prefix = "rise-k8s"

    default_node_pool {
        name = "default"
        node_count = 2
        vm_size = "Standard_D2_v3"
        os_disk_size_gb = 50
    }

    service_principal {
        client_id     = var.appId
        client_secret = var.password
    }

    role_based_access_control {
        enabled = true
    }

    tags = {
        environment = "Production"
    }
}