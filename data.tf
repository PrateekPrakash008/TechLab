data "azurerm_management_group" "parent" {
  name = local.geo["${var.GEO}_${var.ARCH_TYPE}"].parent
}

data "azuread_user" "user" {
  user_principal_name = "${var.SUB_OWNER}@volvocars.com"
}