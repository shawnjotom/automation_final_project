output "vm_hostnames" {
  value = { for vm in azurerm_linux_virtual_machine.linux_vm : vm.name => vm.name }
}

output "vm_domain_names" {
  value = { for vm in azurerm_linux_virtual_machine.linux_vm : vm.name =>  azurerm_public_ip.linux_public_ip[vm.name].fqdn}
}

output "vm_private_ip_addresses" {
  value = { for vm in azurerm_linux_virtual_machine.linux_vm : vm.name => azurerm_network_interface.linux_nic[vm.name].private_ip_address }
}

output "vm_public_ip_addresses" {
  value = { for vm in azurerm_linux_virtual_machine.linux_vm : vm.name => azurerm_public_ip.linux_public_ip[vm.name].ip_address }
}

output "vm_ids" {
  value = [for vm in azurerm_linux_virtual_machine.linux_vm : vm.name]
}
output "linux_nic_ids" {
  value = { for vm in azurerm_linux_virtual_machine.linux_vm : vm.name => azurerm_network_interface.linux_nic[vm.name].id }
}