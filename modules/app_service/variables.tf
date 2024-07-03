variable "resource_group_name" {
  type        = string
  description = "resource_group_name is the name of the Azure Resource Group where the resources will be deployed. This variable is required and must be unique within the Azure subscription"
}

variable "location" {
  type        = string
  description = "This resource block represents a location in the system. It defines the geographical location where a resource will be provisioned."
} 

variable "key_vault_uri" {
  type        = string
  description = "The URI of the Azure Key Vault that contains the secrets for the application."
} 
