provider "azurerm" {
  features {}
#   subscription_id = "xxxxxxxx"
#   # client_id       = "xxxxxxxx"
#   # client_secret   = "xxxxxxxx"
#   tenant_id = "xxxxxxxx"
}
resource "azurerm_resource_group" "rgvnet" {
  name     = var.resource_group_name
  location = var.resource_group_location
}


resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.rgvnet.name
  location            = azurerm_resource_group.rgvnet.location
  address_space       = var.address_space

}

resource "azurerm_subnet" "subnet" {
  #   count                = length(var.subnet_names)
  name                 = var.subnet_names
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.2.0.0/24"]
}

resource "azurerm_network_interface" "nic" {
  # count               = 1
  name                = "internal"
  location            = var.vnet_location
  resource_group_name = var.resource_group_location
  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "random_password" "smgr_password" {
  length      = 16
  special     = true
  min_upper   = 3
  min_lower   = 3
  min_special = 3
  min_numeric = 3
}



resource "azurerm_key_vault_secret" "smgr_password" {
  name         = "smgrpassword"
  value        = random_password.smgr_password.result
  key_vault_id = "/subscriptions/2edbfdca-cb4c-4c5a-86b7-b5b5e0aeaece/resourceGroups/CLDR-SharedResources-eastus2/providers/Microsoft.KeyVault/vaults/CLDR-KeyVault-eastus2"
}

resource "azurerm_linux_virtual_machine_scale_set" "smgrss" {
  name                = "daura-${var.prefix}-vmss"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = "Standard_D64a_v4"
  admin_username      = "adminuser"
  admin_password      = var.admin_password
  instances           = 1



  source_image_reference {
    publisher = "RedHat"
    offer     = "Rhel"
    sku       = "8"
    version   = "latest"
  }

  os_disk {
    managed_disk_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.subnet.id
    }
  }
}