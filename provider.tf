data "azurerm_client_config" "current" {}

terraform {
  cloud {
    organization = "AvayaCloud"
    workspaces {
      name = "ccaasle-azure-terraform-apps-core-daura-smgr"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.10.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.3.1"
    }

  }
}

# provider "azurerm" {
#   features {}
#   disable_correlation_request_id = true
# }

# provider "random" {

# }