resource "azurerm_availability_set" "windows_availability_set" {
  name                = var.availability_set_name
  resource_group_name = var.resource_group_name
  location            = var.location
}



resource "azurerm_windows_virtual_machine" "windows_vm" {
  count               = var.nb_count
  name                = var.windows_vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.windows_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  availability_set_id = azurerm_availability_set.windows_availability_set.id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
  storage_account_uri = var.storage_account_uri
  }

  network_interface_ids =  [element(azurerm_network_interface.windows_nic[*].id,count.index+1)]


  computer_name = "${var.windows_vm_name}-${count.index}"

}

resource "azurerm_virtual_machine_extension" "antimalware_extension" {
  count                 = var.nb_count
  virtual_machine_id    = element(azurerm_windows_virtual_machine.windows_vm[*].id,count.index+1)
  name                  = "Antimalware"
  publisher             = "Microsoft.Azure.Security"
  type                  = "IaaSAntimalware"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = "true"

}

resource "azurerm_network_interface" "windows_nic" {
  count               = var.nb_count
  name                = "${var.windows_vm_name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "${var.windows_vm_name}-ipconfig"
    subnet_id                     = azurerm_subnet.windows_subnet.id
    public_ip_address_id = element(azurerm_public_ip.windows_public_ip[*].id,count.index +1)
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_subnet" "windows_subnet" {
  name                 = "windows-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = "n01663926-VNET"
  address_prefixes     = ["10.0.4.0/24"]
}

resource "azurerm_public_ip" "windows_public_ip" {
  count               = 1
  name                = "${var.windows_vm_name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.public_ip_allocation_method
  domain_name_label = "${var.windows_vm_name}"
}

