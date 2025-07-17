# Azure PIM assignment voia Terraform 🚀


## 📂 AIM:
To establish PIM on specific resource group in azure.

## Conclusion:
1. When we assign PIM on resource group level, the policy must be createed on the RG level else we will get an error of non-existance of `Expiration rule`. [Read this for more details here](https://github.com/hashicorp/terraform-provider-azurerm/issues/22766)

```
resource "azurerm_role_management_policy" "auto-approve" {
  scope              = azurerm_resource_group.sp_rg.id
  role_definition_id = data.azurerm_role_definition.contributor.role_definition_id


  active_assignment_rules {
    expire_after                       = "P180D"
    require_justification              = true
    require_multifactor_authentication = true
  }

  eligible_assignment_rules {
    expiration_required = false
  }

  activation_rules {
    maximum_duration = "PT8H"
    require_approval = false
  }

}
```

2. Role definition id for `pim assignment` must be the role definition id on the subscription level, below is the exact role definition id: 
```
resource "azurerm_pim_eligible_role_assignment" "pim_contributor-rg-sg" {
  scope              = "xxxxxxxxxxx"
  role_definition_id = "${data.azurerm_subscription.primary.id}${data.azurerm_role_definition.contributor.id}"
  principal_id       = "xxxxxxxxxxxxxxx"
}
```

3. Example Case:
```
resource "azurerm_resource_group" "sp_rg" {
  name     = "xxxx"
  location = "xxxx"

}


resource "azurerm_role_management_policy" "auto-approve" {
  scope              = azurerm_resource_group.sp_rg.id
  role_definition_id = data.azurerm_role_definition.contributor.role_definition_id


  active_assignment_rules {
    expire_after                       = "P180D"
    require_justification              = true
    require_multifactor_authentication = true
  }

  eligible_assignment_rules {
    expiration_required = false
  }

  activation_rules {
    maximum_duration = "PT8H"
    require_approval = false
  }

}

resource "azurerm_pim_eligible_role_assignment" "pim_contributor-rg-sg" {
  scope              = azurerm_resource_group.sp_rg.id
  role_definition_id = "${data.azurerm_subscription.primary.id}${data.azurerm_role_definition.contributor.id}"
  principal_id       = "xxxxxxxxx"
}

```