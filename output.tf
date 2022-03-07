output "resource_group_name" {
    value = azurerm_resource_group.state-rg.name
}
output "kubernetes_cluster_name" {
    value = azurerm_kubernetes_cluster.rf-prod.name
}
output "terraform_state_resource_group_name" {
    value = azurerm_resource_group.state-rg.name
}
output "terraform_state_storage_account" {
    value = azurerm_storage_account.state-sta.name
}
output "terraform_state_storage_container_core" {
    value = azurerm_storage_container.core-container.name
}