resource "random_password" "ixmessaging_password" {
  length      = 15
  special     = true
  min_upper   = 3
  min_lower   = 3
  min_special = 3
  min_numeric = 3
}


data "azurerm_resource_group" "rg_hub_vnet" {
  name     = "rg-vnet-shared-services-${var.location}"
}

data "azurerm_resource_group" "rg_corespoke_vnet" {
  name     = "rg-vnet-corespoke-${var.location}-${var.customername}"
}

data "azurerm_resource_group" "rg_cc_apps" {
  name     = "rg-vms-cc-apps-${var.location}-${var.customername}"
}

data "azurerm_resource_group" "rg_uc_apps" {
  name     = "rg-vms-uc-apps-${var.location}-${var.customername}"
}

data "azurerm_resource_group" "rg_coreservices" {
  name     = "rg-coreservices-${var.location}-${var.customername}"
}

data "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-hub-${var.location}-${var.customername}"
  resource_group_name = data.azurerm_resource_group.rg_hub_vnet.name
}

data "azurerm_virtual_network" "corespoke_vnet" {
  name                = "vnet-core-${var.location}-${var.customername}"
  resource_group_name = data.azurerm_resource_group.rg_hub_vnet.name
}

data "azurerm_key_vault" "customer_keyvault" {
  name = "kv-${var.customername}-${var.location}"
  resource_group_name = data.azurerm_resource_group.rg_coreservices.name
}