
# Deploy service provider resource group in customer subscription
resource "azurerm_resource_group" "sp_rg" {
  name     = "rg-pim-test-nonprod-003"
  location = "West Europe"

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "time_sleep" "wait_30_seconds_pim" {
  depends_on      = [azurerm_resource_group.sp_rg]
  create_duration = "30s"
}

# Azure PIM Configuration for Security Group
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

  depends_on = [ time_sleep.wait_30_seconds_pim ]
}

resource "time_sleep" "wait_30_seconds_pim_1" {
  depends_on      = [azurerm_role_management_policy.auto-approve]
  create_duration = "30s"
}

# Assign PIM contributor role to service principal on subscription
resource "azurerm_pim_eligible_role_assignment" "pim_contributor-rg-sg" {
  scope              = azurerm_resource_group.sp_rg.id
  role_definition_id = "${data.azurerm_subscription.primary.id}${data.azurerm_role_definition.contributor.id}"
  principal_id       = "054a05fd-0c69-4e38-80ec-3a7788e6d575"

  depends_on = [ time_sleep.wait_30_seconds_pim_1 ]
}

