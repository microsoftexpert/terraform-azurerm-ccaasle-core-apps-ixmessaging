data "azurerm_client_config" "current" {}

terraform {
  cloud {
    organization = "AvayaCloud"
    workspaces {
      name = "ccaasle-core-apps-ixmessaging"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.15.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.3.2"
    }

  }
}

provider "azurerm" {
  features {}
  subscription_id = "53eddfd8-cb7b-4235-8d0c-188371c1debc"
  disable_correlation_request_id = true
}


provider "random" {

}

data "azurerm_resource_group" "sharedservices_vnet_resourcegroup" {
  provider = azurerm.sharedservices
  name     = "rg-vnet-shared-services-eastus2"
}

data "azurerm_virtual_network" "sharedservices_vnet" {
  provider            = azurerm.sharedservices
  name                = "vnet-sharedservices-eastus2"
  resource_group_name = data.azurerm_resource_group.sharedservices_vnet_resourcegroup.name


}