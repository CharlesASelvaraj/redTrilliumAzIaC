variable "container_names" {
  type    = list(string)
  default = ["corporate", "management", "network","identity","workload"]
}

variable "resource_group_name " {
  type    = string
  default = "global-tfstate-useast-rg"  
}

variable "storage_account_name" {
  type    = string
  default = "globaltfstate"  
}

variable "location" {
   type    = string
  default =  "useast"
}

variable "terraform_tfstate_key" {
  type    = string
  default = "corporate.terraform.tfstate"  
}