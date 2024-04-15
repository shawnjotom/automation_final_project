resource "azurerm_public_ip" "lb_public_ip" {
  name                = "lb-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_lb" "main" {
  name                = var.lb_name
  resource_group_name = var.resource_group_name
  location            = var.location

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shown.JoTom"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name                = "backend-pool"
  loadbalancer_id     = azurerm_lb.main.id
}




resource "azurerm_network_interface_backend_address_pool_association" "vm_association" {
  for_each                  = var.linux_nic_ids
  network_interface_id      = each.value
  ip_configuration_name     = "${each.key}-ipconfig"
  backend_address_pool_id   = azurerm_lb_backend_address_pool.backend_pool.id
}