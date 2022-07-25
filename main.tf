resource "azurerm_key_vault_secret" "ixmessaging_password" {
  name         = "ixmessagingpassword"
  value        = random_password.ixmessaging_password.result
  key_vault_id = data.azurerm_key_vault.customer_keyvault.id
}

resource "azurerm_windows_virtual_machine_scale_set" "ixmessaging" {
  name                = "${var.customername}-ixm"
  resource_group_name = data.azurerm_resource_group.rg_uc_apps.name
  location            = var.location
  sku                 = "Standard_D8s_v4"
  admin_username      = "adminuser"
  admin_password      = azurerm_key_vault_secret.ixmessaging_password.value
  license_type = "Windows_Server"
  instances           = 3
  enable_automatic_updates = true
  tags = var.tags
  #source_image_id = ""



  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    managed_disk_type = "Standard_LRS"
    caching              = "ReadWrite"
    
  }

  network_interface {
    name    = "internalinterface"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = data.azurerm_virtual_network.corespoke_vnet.subnet[2].id
    }
  }
}