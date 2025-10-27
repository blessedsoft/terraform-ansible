output "public_ips" {
  description = "Public IPs of all VMs"
  value       = [for vm in azurerm_linux_virtual_machine.vm : vm.public_ip_address]
}
