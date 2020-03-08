variable "subscription_id" {
  description = "Enter Subscription ID for provisioning resources in Azure"
}

variable "client_id" {
  description = "Enter Client ID for Application in Azure AD"
}

variable "client_secret" {
  description = "Enter Client secret for Application in Azure AD"
}

variable "tenant_id" {
  description = "Enter Tenand ID / Directory ID  of your Azure AD. Login Azure id script install cli"
}

variable "resource_group_name" {
  description = "Enter Resource group name"
}

variable "location" {
  description = "Enter location"
}

variable "container_registry_name" {
  description = "Enter conatainer registry name"
}