variable "location" {
  type    = string
  default = "CanadaCentral"
}

variable "resource_group_name" {
  type    = string
  default = "n01663926-RG"
}

variable "linux_availability_set_name" {

}

variable "network_watcher_name" {

}

variable "azure_monitor_name" {

}


variable "vm_names" {
  type    = list(string)
  default = ["vm-linux-01", "vm-linux-02", "vm-linux-03","vm-linux-04"]
}

variable "dns_labels" {
  type        = list(string)
  description = "List of DNS labels for VMs."
  default     = ["vm-linux-01", "vm-linux-02", "vm-linux-03","vm-linux-04"]
}

variable "storage_account_uri" {
  type = string
}


variable "admin_username" {
  type    = string
  default = "adminuser" 
}

variable "admin_password" {
  type    = string
  default = "P@ssw0rd123!"  
}

variable "public_ip_allocation_method" {
  default     = "Dynamic"
}

variable "public_key_path" {
  type    = string
  default = "C:\\Users\\shown\\.ssh\\id_rsa.pub"
}

variable "private_key_path" {
  type    = string
  default = "C:\\Users\\shown\\.ssh\\id_rsa"
}


