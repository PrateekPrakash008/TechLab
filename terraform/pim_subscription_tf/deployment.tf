resource "azurerm_management_group_subscription_association" "assign_sub" {
  management_group_id = data.azurerm_management_group.parent.id
  subscription_id     = "/subscriptions/${var.SUB_ID}"

  depends_on = [
    time_sleep.wait_30_seconds_pim

  ]
}

resource "azuread_group" "sub_owner" {
  display_name = "cld-${var.NEW_SUB_NAME}-sg"
  owners       = [data.azuread_user.user.object_id]
  members = [
    data.azuread_user.user.object_id
  ]
  security_enabled = true
  lifecycle {
    ignore_changes = [
      #members,
      #owners
    ]
  }
}

resource "azurerm_role_assignment" "sub_owner" {
  scope                = "/subscriptions/${var.SUB_ID}"
  role_definition_name = "Reader"
  principal_id         = resource.azuread_group.sub_owner.object_id

  depends_on = [azuread_group.sub_owner]
}


resource "time_sleep" "wait_30_seconds_pim" {
  depends_on = [azuread_group.sub_owner]

  create_duration = "30s"
}

resource "azurerm_role_management_policy" "auto-approve" {
  scope              = "/subscriptions/${var.SUB_ID}"
  role_definition_id = var.ROLE_ID

  active_assignment_rules {
    expiration_required = true
    expire_after        = "P180D"
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

resource "azurerm_pim_eligible_role_assignment" "subscription_owner" {
  scope              = "/subscriptions/${var.SUB_ID}"
  role_definition_id = "/subscriptions/${var.SUB_ID}${var.ROLE_ID}"
  principal_id       = resource.azuread_group.sub_owner.object_id

   timeouts {
    create = "1m"
  }

  depends_on = [azurerm_role_management_policy.auto-approve] 
}