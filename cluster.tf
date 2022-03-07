provider "azurerm" {
    features {}
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