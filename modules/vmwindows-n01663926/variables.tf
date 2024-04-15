variable "location" {
  type    = string
  default = "CanadaCentral"
}

variable "resource_group_name" {
  type    = string
  default = "n01663926-RG"
}

variable "availability_set_name" {

}


variable "storage_account_uri" {
  type = string
}




variable "windows_vm_name" {

}

variable "windows_size" {

}

variable "admin_username" {
  default     = "adminuser"
}

variable "admin_password" {
  default     = "Password123!@#"
}

variable "public_ip_allocation_method" {

}

variable "nb_count" {
  default = "1"
}