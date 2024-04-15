resource "azurerm_availability_set" "linux_availability_set" {
  name                = var.linux_availability_set_name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shown.JoTom"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}



resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each            = toset(var.vm_names)
  name                = each.key
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_DS1_v2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.linux_nic[each.key].id,
  ]

  admin_ssh_key {
    username = var.admin_username
    public_key = file(var.public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  availability_set_id = azurerm_availability_set.linux_availability_set.id

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shown.JoTom"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each            = toset(var.vm_names)
  name                = var.network_watcher_name
  virtual_machine_id  = azurerm_linux_virtual_machine.linux_vm[each.key].id
  publisher           = "Microsoft.Azure.NetworkWatcher"
  type                = "NetworkWatcherAgentLinux"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = "true"
  depends_on = [ azurerm_linux_virtual_machine.linux_vm,null_resource.display_info ]

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shown.JoTom"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each            = toset(var.vm_names)
  name                = var.azure_monitor_name
  virtual_machine_id  = azurerm_linux_virtual_machine.linux_vm[each.key].id
  publisher           = "Microsoft.Azure.Monitor"
  type                = "AzureMonitorLinuxAgent"
  auto_upgrade_minor_version = "true"
  type_handler_version = "1.0"

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shown.JoTom"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_network_interface" "linux_nic" {
  for_each            = toset(var.vm_names)
  name                = "${each.key}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "${each.key}-ipconfig"
    subnet_id                     = azurerm_subnet.linux_subnet.id
    public_ip_address_id = azurerm_public_ip.linux_public_ip[each.key].id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shown.JoTom"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_public_ip" "linux_public_ip" {
  for_each            = toset(var.vm_names)
  name                = "${each.key}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.public_ip_allocation_method
  domain_name_label = each.key

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shown.JoTom"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_subnet" "linux_subnet" {
  name                 = "linux-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = "n01663926-VNET"
  address_prefixes     = ["10.0.2.0/24"]

}

