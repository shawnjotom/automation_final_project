variable "location" {

}

variable "resource_group_name" {

}

variable "admin_username" {
   
}

variable "admin_password" {
  description = "The administrator password for the PostgreSQL server."
  default     = "P@ssw0rd" 
sensitive = true
}

variable "name" {
 
}

variable "sku_name" {

}

variable "postgresql_version" {
      
}

variable "ssl_enforcement_enabled" {
}


variable "storage_mb"{
 
}

variable backup_retention_days {

}

