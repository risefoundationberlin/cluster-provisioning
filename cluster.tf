provider "azurerm" {
    features {}
}

resource "azurerm_kubernetes_cluster" "rf-prod" {
    name = "rf-production"
    location = "Germany West Central"
    resource_group_name = "dev-ops-rg"
    dns_prefix = "rise-k8s"

    default_node_pool {
        name = "default"
        node_count = 1
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
