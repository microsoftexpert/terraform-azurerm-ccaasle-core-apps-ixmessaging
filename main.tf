resource "azurerm_key_vault_secret" "ixmessaging_password" {
  name         = "ixmessagingpassword"
  value        = random_password.ixmessaging_password.result
  key_vault_id = data.azurerm_key_vault.customer_keyvault.id
}

resource "azurerm_network_interface" "ixmessaging1" {
  name                = "${var.customername}-ixm1-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg_uc_apps.name
  tags                = var.tags



  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.windows_subnet.id
    private_ip_address_allocation = "Dynamic"
  }

}
resource "azurerm_windows_virtual_machine" "ixmessaging1" {
  name                = "${var.customername}-ixm1"
  resource_group_name = data.azurerm_resource_group.rg_uc_apps.name
  location            = var.location
  size                = "Standard_D8s_v3"
  admin_username      = "adminuser"
  admin_password      = data.azurerm_key_vault_secret.ixmessaging_password.value
  license_type        = "Windows_Server"

  enable_automatic_updates = true
  tags                     = var.tags
  zone                     = "1"
  source_image_id          = "/subscriptions/2edbfdca-cb4c-4c5a-86b7-b5b5e0aeaece/resourceGroups/rg-vm-image-hardening/providers/Microsoft.Compute/galleries/acgaocpimages01/images/win19-avaya-cis1-base-20220712"

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"

  }

  network_interface_ids = [
    azurerm_network_interface.ixmessaging1.id,

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

resource "azurerm_virtual_machine_extension" "join_ixmessaging1_to_domain" {
  name                 = "domjoin"
  virtual_machine_id   = azurerm_windows_virtual_machine.ixmessaging1.id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"
  # What the settings mean: https://docs.microsoft.com/en-us/windows/desktop/api/lmjoin/nf-lmjoin-netjoindomain
  settings           = <<SETTINGS
{
"Name": "${var.customername}.avayacloud.com",
"OUPath": "OU=Servers,DC=${var.customername},DC=avayacloud,DC=com",
"User": "${var.customername}.avayacloud.com\\avmadmin",
"Restart": "true",
"Options": "3"
}
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
{
"Password": "${data.azurerm_key_vault_secret.DCAdminPassword.value}"
}
PROTECTED_SETTINGS
  depends_on = [
    azurerm_windows_virtual_machine.ixmessaging1,
  ]
}

resource "azurerm_network_interface" "ixmessaging2" {
  name                = "${var.customername}-ixm2-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg_uc_apps.name
  tags                = var.tags



  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.windows_subnet.id
    private_ip_address_allocation = "Dynamic"
  }

}
resource "azurerm_windows_virtual_machine" "ixmessaging2" {
  name                = "${var.customername}-ixm2"
  resource_group_name = data.azurerm_resource_group.rg_uc_apps.name
  location            = var.location
  size                = "Standard_D8s_v3"
  admin_username      = "adminuser"
  admin_password      = data.azurerm_key_vault_secret.ixmessaging_password.value
  license_type        = "Windows_Server"

  enable_automatic_updates = true
  tags                     = var.tags
  zone                     = "1"
  source_image_id          = "/subscriptions/2edbfdca-cb4c-4c5a-86b7-b5b5e0aeaece/resourceGroups/rg-vm-image-hardening/providers/Microsoft.Compute/galleries/acgaocpimages01/images/win19-avaya-cis1-base-20220712"

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"

  }

  network_interface_ids = [
    azurerm_network_interface.ixmessaging2.id,

  ]
  depends_on = [
    azurerm_key_vault_secret.ixmessaging_password,
  ]
}

resource "azurerm_virtual_machine_extension" "join_ixmessaging2_to_domain" {
  name                 = "domjoin"
  virtual_machine_id   = azurerm_windows_virtual_machine.ixmessaging2.id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"
  # What the settings mean: https://docs.microsoft.com/en-us/windows/desktop/api/lmjoin/nf-lmjoin-netjoindomain
  settings           = <<SETTINGS
{
"Name": "${var.customername}.avayacloud.com",
"OUPath": "OU=Servers,DC=${var.customername},DC=avayacloud,DC=com",
"User": "${var.customername}.avayacloud.com\\avmadmin",
"Restart": "true",
"Options": "3"
}
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
{
"Password": "${data.azurerm_key_vault_secret.DCAdminPassword.value}"
}
PROTECTED_SETTINGS
  depends_on = [
    azurerm_windows_virtual_machine.ixmessaging2,
  ]
}

resource "azurerm_network_interface" "ixmessaging3" {
  name                = "${var.customername}-ixm3-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg_uc_apps.name
  tags                = var.tags



  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.windows_subnet.id
    private_ip_address_allocation = "Dynamic"
  }

}
resource "azurerm_windows_virtual_machine" "ixmessaging3" {
  name                     = "${var.customername}-ixm3"
  resource_group_name      = data.azurerm_resource_group.rg_uc_apps.name
  location                 = var.location
  size                     = "Standard_D8s_v3"
  admin_username           = "adminuser"
  admin_password           = data.azurerm_key_vault_secret.ixmessaging_password.value
  license_type             = "Windows_Server"
  enable_automatic_updates = true
  tags                     = var.tags
  zone                     = "1"
  source_image_id          = "/subscriptions/2edbfdca-cb4c-4c5a-86b7-b5b5e0aeaece/resourceGroups/rg-vm-image-hardening/providers/Microsoft.Compute/galleries/acgaocpimages01/images/win19-avaya-cis1-base-20220712"

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"

  }

  network_interface_ids = [
    azurerm_network_interface.ixmessaging3.id,

  ]
  depends_on = [
    azurerm_key_vault_secret.ixmessaging_password,
  ]
}

resource "azurerm_virtual_machine_extension" "join_ixmessaging3_to_domain" {
  name                 = "domjoin"
  virtual_machine_id   = azurerm_windows_virtual_machine.ixmessaging3.id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"
  # What the settings mean: https://docs.microsoft.com/en-us/windows/desktop/api/lmjoin/nf-lmjoin-netjoindomain
  settings           = <<SETTINGS
{
"Name": "${var.customername}.avayacloud.com",
"OUPath": "OU=Servers,DC=${var.customername},DC=avayacloud,DC=com",
"User": "${var.customername}.avayacloud.com\\avmadmin",
"Restart": "true",
"Options": "3"
}
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
{
"Password": "${data.azurerm_key_vault_secret.DCAdminPassword.value}"
}
PROTECTED_SETTINGS
  depends_on = [
    azurerm_windows_virtual_machine.ixmessaging3,
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