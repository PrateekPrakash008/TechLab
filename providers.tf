terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=4.36.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "=2.22.0"
    }
    infoblox = {
      source = "infobloxopen/infoblox"
      version = "=2.5.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-tfinfra-prod-001"
    storage_account_name = "stpcetfinfraweuprod001"
    container_name       = "tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias = "onboarded"
  features {}
  subscription_id            = var.SUB_ID
}
# provider "azurerm" {
#   alias = "network"
#   features {}
#   subscription_id            = local.geo["${var.GEO}_${var.ARCH_TYPE}"].net_sub_id
# }

# provider "azurerm" {
#   alias = "mgmt"
#   features {}
#   subscription_id            = var.MGMT_SUB_ID
# }

# provider "azurerm" {
#   alias = "log"
#   features {}
#   subscription_id            = var.CENTRAL_LOG_SUB_ID
# }

# provider "infoblox" {
#   username = var.INFOBLOX_USER
#   password = var.INFOBLOX_SECRET
#   server   = "gotib001.got.volvocars.net"
# }
