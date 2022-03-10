# cluster-provisioning
This repo contains code for provisiong an AKS (Azure) cluster. It uses a remote backend state storage for terraform. Storage account and container, resource groups and service principals are created before with azure cli. Below are the commands used for it.

```
az ad sp create-for-rbac --role="Contributor"  --scopes="/subscriptions/{subscriptionid}" --name="service_principal_name" --sdk-auth

az group create --name resource_group_name --location "location_name"

az storage account create --resource-group resource_group_name --name storage_Account_name --sku Standard_LRS --encryption-services blob

ACCOUNT_KEY=$(az storage account keys list --resource-group resource_group_name --account-name storage_Account_name  --query [0].value -o tsv)

az storage container create --name conatiner_name --account-name storage_Account_name --account-key $ACCOUNT_KEY

```
