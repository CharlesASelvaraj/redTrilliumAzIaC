variable "admin_user_name" {
  type        = string
  description = "The admin user name for the Azure SQL instance."
}

variable "admin_password" {
  type        = string
  description = "The admin password for the Azure SQL instance."
  sensitive   = true
}

variable "email_address" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}