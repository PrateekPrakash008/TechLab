
locals {
  allocated_prefix = {
    XS = {
      len = "26"
    }
    S = {
      len = "25"
    }
    M = {
      len = "24"
    }
    L = {
      len = "23"
    }
    HXL = {
      len = "22"
    }
    HXXL = {
      len = "21"
    }
    HXXXL = {
      len = "20"
    }
    HXXXXL = {
      len = "19"
    }
  }
  vnet_newbits = {
    XS = {
      newbits = "1"
    }
    S = {
      newbits = "2"
    }
    M = {
      newbits = "3"
    }
    L = {
      newbits = "4"
    }
    HXL = {
      newbits = "5"
    }
    HXXL = {
      newbits = "6"
    }
  }
  geo = {
    APEC_corp = {
      parent_cidr      = "10.44.0.0/16"
      dns_servers      = ["10.44.138.132", "10.44.138.133"]
      fw_ip            = "10.44.139.4"
      location         = "Southeast Asia"
      shorted_location = "southeastasia"
      short_location   = "sea"
      hub_vnet_rg_name = "VolvoCars-vnethub-southeastasia"
      hub_vnet_name    = "VolvoCars-hub-southeastasia"
      hub_rt_name      = "rt-hub-southeastasia-gateway-subnet"
      net_sub_id       = "03cc3c32-0993-4e6b-a2dc-45999600c58c"
      parent           = "VolvoCars-corp-sea"
      allowed_location_definition_id = null
      allowed_locations              = null
    }
EMEA_corp = {
      parent_cidr      = "10.46.0.0/16"
      dns_servers      = ["10.40.136.81", "10.40.136.82"]
      fw_ip            = "10.46.139.4"
      location         = "West Europe"
      shorted_location = "westeurope"
      short_location   = "weu"
      hub_vnet_rg_name = "VolvoCars-vnethub-westeurope-003"
      hub_vnet_name    = "VolvoCars-hub-westeurope-003"
      hub_rt_name      = "rt-weu-hub-gateway-subnet-003"
      net_sub_id       = "4fabc78b-3a1e-4783-bf18-a2a2da415035"
      parent           = "VolvoCars-corp"
      allowed_location_definition_id = null
      allowed_locations              = null
    }
    AMER_corp = {
      parent_cidr      = "10.42.0.0/16"
      dns_servers      = ["10.244.0.15", "10.244.0.20"]
      fw_ip            = "10.42.139.4"
      location         = "East US"
      shorted_location = "eastus"
      short_location   = "eus"
      hub_vnet_rg_name = "VolvoCars-vnethub-eastus"
      hub_vnet_name    = "VolvoCars-hub-eastus"
      hub_rt_name      = "rt-hub-eastus-gateway-subnet"
      net_sub_id       = "b7c5d6a9-7552-4e53-87d0-f9b2e2ca644d"
      parent           = "VolvoCars-corp-amer"
      allowed_location_definition_id = null
      allowed_locations              = null
    }
    SWDN_corp = {
      parent_cidr      = "10.43.0.0/16"
      dns_servers      = ["10.244.0.15", "10.244.0.20"]
      fw_ip            = "10.43.139.4"
      location         = "Sweden Central"
      shorted_location = "swedencentral"
      short_location   = "sec"
      hub_vnet_rg_name = "VolvoCars-vnethub-swedencentral"
      hub_vnet_name    = "VolvoCars-hub-swedencentral"
      hub_rt_name      = "rt-hub-swedencentral-gateway-subnet"
      net_sub_id       = "4fabc78b-3a1e-4783-bf18-a2a2da415035"
      parent           = "VolvoCars-corp-swdn"
      allowed_location_definition_id = null
      allowed_locations              = null
    }
    APEC_online = {
      location                       = "Southeast Asia"
      shorted_location               = "southeastasia"
      short_location                 = "sea"
      parent                         = "VolvoCars-online"
      hub_vnet_rg_name               = "VolvoCars-vnethub-southeastasia"
      hub_vnet_name                  = "VolvoCars-hub-southeastasia"
      hub_rt_name                    = "rt-hub-southeastasia-gateway-subnet"
      net_sub_id                     = "03cc3c32-0993-4e6b-a2dc-45999600c58c"
      allowed_location_definition_id = "/providers/Microsoft.Management/managementGroups/VolvoCars/providers/Microsoft.Authorization/policySetDefinitions/sea_deny_governance"
      allowed_locations              = ["Southeast Asia", "East Asia"]
    }
    EMEA_online = {
      location                       = "West Europe"
      shorted_location               = "westeurope"
      short_location                 = "weu"
      parent                         = "VolvoCars-online"
      hub_vnet_rg_name               = "VolvoCars-vnethub-westeurope"
      hub_vnet_name                  = "VolvoCars-hub-westeurope"
      hub_rt_name                    = "rt-hub-westeurope-gateway-subnet"
      net_sub_id                     = "4fabc78b-3a1e-4783-bf18-a2a2da415035"
      allowed_location_definition_id = null
      allowed_locations              = null
    }
    AMER_online = {
      location                       = "East US"
      shorted_location               = "eastus"
      short_location                 = "eus"
      parent                         = "VolvoCars-online"
      hub_vnet_rg_name               = "VolvoCars-vnethub-eastus"
      hub_vnet_name                  = "VolvoCars-hub-eastus"
      hub_rt_name                    = "rt-hub-eastus-gateway-subnet"
      net_sub_id                     = "b7c5d6a9-7552-4e53-87d0-f9b2e2ca644d"
      allowed_location_definition_id = "/providers/Microsoft.Management/managementGroups/VolvoCars/providers/Microsoft.Authorization/policySetDefinitions/eus_deny_governance"
      allowed_locations              = ["East US", "West US", "East US 2", "Central US", "North Central US", "South Central US", "West US 2", "West Central US", "West US 3"]
    }
    SWDN_online = {
      location                       = "Sweden Central"
      shorted_location               = "swedencentral"
      short_location                 = "sec"
      parent                         = "VolvoCars-online"
      hub_vnet_rg_name               = "VolvoCars-vnethub-swedencentral"
      hub_vnet_name                  = "VolvoCars-hub-swedencentral"
      hub_rt_name                    = "rt-hub-swedencentral-gateway-subnet"
      net_sub_id                     = "4fabc78b-3a1e-4783-bf18-a2a2da415035"
      allowed_location_definition_id = "/providers/Microsoft.Management/managementGroups/VolvoCars/providers/Microsoft.Authorization/policySetDefinitions/sec_deny_governance"
      allowed_locations              = ["Sweden Central", "Sweden South"]
    }  
  }
}
