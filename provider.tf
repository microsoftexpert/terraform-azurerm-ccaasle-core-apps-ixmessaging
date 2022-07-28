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
  subscription_id                = "2edbfdca-cb4c-4c5a-86b7-b5b5e0aeaece"
  disable_correlation_request_id = true
}


provider "random" {

}

