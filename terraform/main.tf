# Contributor Role Data Source
data "azurerm_role_definition" "contributor" {
    name = "Contributor"
}

data "azurerm_subscription" "primary" {
  subscription_id = "0c6364d5-fd1c-4270-a5dd-bfe600e46d04"
}

output "output_1_rg_id" {
  value =  resource.azurerm_resource_group.sp_rg.id
}

output "output_2_rd_id" {
  value =  data.azurerm_role_definition.contributor.id
}

output "output_3_role_definition_id_1" {
  value =  data.azurerm_role_definition.contributor.role_definition_id
}

output "output_4_role_definition_id_2" {
  value =  "${resource.azurerm_resource_group.sp_rg.id}${data.azurerm_role_definition.contributor.id}"
}

output "output_5_role_definition_id_3" {
  value =  "subscriptions/0c6364d5-fd1c-4270-a5dd-bfe600e46d04${data.azurerm_role_definition.contributor.id}"
}

output "output_6_auto_approve_policy" {
  value = azurerm_role_management_policy.auto-approve
}

output "output_7_pim_assignment" {
  value = azurerm_pim_eligible_role_assignment.pim_contributor-rg-sg
}