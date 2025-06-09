# Provider Configuration
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.29.0"
    }
  }
}

provider azurerm {
    features{}
    subscription_id = "0c6364d5-fd1c-4270-a5dd-bfe600e46d04"
}


