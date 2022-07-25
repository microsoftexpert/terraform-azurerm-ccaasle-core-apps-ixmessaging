resource "random_password" "ixmessaging_password" {
  length      = 15
  special     = true
  min_upper   = 3
  min_lower   = 3
  min_special = 3
  min_numeric = 3
}


data "azurerm_resource_group" "rg_hub_vnet" {
  name     = "rg-vnet-shared-services-eastus2"
}

data "azurerm_resource_group" "rg_corespoke_vnet" {
  name     = "rg-vnet-corespoke-eastus2-DEV1"
}

data "azurerm_resource_group" "rg_cc_apps" {
  name     = "rg-vms-cc-apps-eastus2-DEV1"
}

data "azurerm_resource_group" "rg_uc_apps" {
  name     = "rg-vms-uc-apps-eastus2-DEV1"
}

data "azurerm_resource_group" "rg_coreservices" {
  name     = "rg-coreservices-${var.location}-${var.customername}"
}

data "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-hub-eastus2-DEV1"
  resource_group_name = data.azurerm_resource_group.rg_hub_vnet.name
}

data "azurerm_virtual_network" "corespoke_vnet" {
  name                = "vnet-core-eastus2-DEV1"
  resource_group_name = data.azurerm_resource_group.rg_hub_vnet.name
}

data "azurerm_key_vault" "customer_keyvault" {
  name = "kv-${var.customername}-${var.location}"
  resource_group_name = data.azurerm_resource.group.rg_coreservices.name
}