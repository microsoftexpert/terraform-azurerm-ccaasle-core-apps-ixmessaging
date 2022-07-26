resource "azurerm_key_vault_secret" "ixmessaging_password" {
  name         = "ixmessagingpassword"
  value        = random_password.ixmessaging_password.result
  key_vault_id = data.azurerm_key_vault.customer_keyvault.id
}

resource "azurerm_network_interface" "ixmessaging1_zone2" {
  name                = "${var.customername}-ixm1zone2-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg_uc_apps.name
  tags                = var.tags



  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.windows_subnet.id
    private_ip_address_allocation = "Dynamic"
  }

}
resource "azurerm_windows_virtual_machine" "ixmessaging1_zone2" {
  name                = "${var.customername}-ixm1zone2"
  resource_group_name = data.azurerm_resource_group.rg_uc_apps.name
  location            = var.location
  size                 = "Standard_D8s_v3s"
  admin_username      = "adminuser"
  admin_password      = data.azurerm_key_vault_secret.ixmessaging_password.value
  license_type = "Windows_Server"

  enable_automatic_updates = true
  tags = var.tags
  zone = "1"
  source_image_id = "/subscriptions/2edbfdca-cb4c-4c5a-86b7-b5b5e0aeaece/resourceGroups/rg-vm-image-hardening/providers/Microsoft.Compute/galleries/acgaocpimages01/images/win19-avaya-cis1-base-20220712"

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    
  }

    network_interface_ids = [
    azurerm_network_interface.ixmessaging1_zone2.id,

  ]
  /*

  network_interface {
    name    = "internalinterface"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = data.azurerm_subnet.windows_subnet.id
    }
  }
  */
  depends_on = [
    azurerm_key_vault_secret.ixmessaging_password,
  ]
}

resource "azurerm_network_interface" "ixmessaging2_zone2" {
  name                = "${var.customername}-ixm2zone2-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg_uc_apps.name
  tags                = var.tags



  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.windows_subnet.id
    private_ip_address_allocation = "Dynamic"
  }

}
resource "azurerm_windows_virtual_machine" "ixmessaging2_zone2" {
  name                = "${var.customername}-ix2zone2"
  resource_group_name = data.azurerm_resource_group.rg_uc_apps.name
  location            = var.location
  size                 = "Standard_D8s_v3s"
  admin_username      = "adminuser"
  admin_password      = data.azurerm_key_vault_secret.ixmessaging_password.value
  license_type = "Windows_Server"

  enable_automatic_updates = true
  tags = var.tags
  zone = "2"
  source_image_id = "/subscriptions/2edbfdca-cb4c-4c5a-86b7-b5b5e0aeaece/resourceGroups/rg-vm-image-hardening/providers/Microsoft.Compute/galleries/acgaocpimages01/images/win19-avaya-cis1-base-20220712"

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    
  }

      network_interface_ids = [
    azurerm_network_interface.ixmessaging2_zone2.id,

  ]
  depends_on = [
    azurerm_key_vault_secret.ixmessaging_password,
  ]
}

resource "azurerm_network_interface" "ixmessaging3_zone2" {
  name                = "${var.customername}-ixm3zone2-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg_uc_apps.name
  tags                = var.tags



  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.windows_subnet.id
    private_ip_address_allocation = "Dynamic"
  }

}
resource "azurerm_windows_virtual_machine" "ixmessaging3_zone2" {
  name                = "${var.customername}-ixm3zone2"
  resource_group_name = data.azurerm_resource_group.rg_uc_apps.name
  location            = var.location
  size                 = "Standard_D8s_v3s"
  admin_username      = "adminuser"
  admin_password      = data.azurerm_key_vault_secret.ixmessaging_password.value
  license_type = "Windows_Server"
  enable_automatic_updates = true
  tags = var.tags
  zone = "3"
  source_image_id = "/subscriptions/2edbfdca-cb4c-4c5a-86b7-b5b5e0aeaece/resourceGroups/rg-vm-image-hardening/providers/Microsoft.Compute/galleries/acgaocpimages01/images/win19-avaya-cis1-base-20220712"

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    
  }

      network_interface_ids = [
    azurerm_network_interface.ixmessaging3_zone2.id,

  ]
  depends_on = [
    azurerm_key_vault_secret.ixmessaging_password,
  ]
}
/*
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
  zones = ["1",]
  source_image_id = "/subscriptions/2edbfdca-cb4c-4c5a-86b7-b5b5e0aeaece/resourceGroups/rg-vm-image-hardening/providers/Microsoft.Compute/galleries/acgaocpimages01/images/win19-avaya-cis1-base-20220712"

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    
  }

  network_interface {
    name    = "internalinterface"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = data.azurerm_subnet.windows_subnet.id
    }
  }
  depends_on = [
    azurerm_key_vault_secret.ixmessaging_password,
  ]
}
*/