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
  disable_correlation_request_id = true
}


provider "random" {

}

