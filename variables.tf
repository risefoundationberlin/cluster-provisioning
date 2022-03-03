variable "resource_location" {
  description = " Resource Location Group"
  default = "germanycentral"
}

variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
}