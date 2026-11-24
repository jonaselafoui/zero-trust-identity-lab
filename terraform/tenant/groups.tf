resource "azuread_group" "SG-CFG-LAB" {
  display_name     = "SG-CFG-LAB"
  security_enabled = true
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = "user.department -eq \"Vertrieb\" -and user.accountEnabled -eq true"
  }
}

data "azuread_users" "group_owners" {
  user_principal_names = var.group_owner_upns
}

resource "azuread_group" "dynamicgroups" {
  for_each = local.dynamicsggroups

  display_name            = each.value.display_name
  security_enabled        = true
  prevent_duplicate_names = true
  owners                  = data.azuread_users.group_owners.object_ids
  types                   = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = "user.${each.value.rule_attribute} -eq \"${each.value.rule_value}\" -and user.accountEnabled -eq true"
  }
}

resource "azuread_group" "staticgroups" {
  for_each = local.staticsggroups

  display_name            = each.value.display_name
  security_enabled        = true
  prevent_duplicate_names = true
  owners                  = data.azuread_users.group_owners.object_ids

  members = each.value.team == "" && each.value.employee_type == "" ? null : [
    for k, u in local.users : azuread_user.this[k].object_id
    if u.enabled
    && (each.value.team == "" || u.team == each.value.team)
    && (each.value.employee_type == "" || u.employee_type == each.value.employee_type)
  ]
}

resource "azuread_group_license" "M365E5_assignment" {
  group_object_id = azuread_group.staticgroups["SGID0021"].object_id
  sku_id          = "cd2925a3-5076-4233-8931-638a8c94f773"
}
