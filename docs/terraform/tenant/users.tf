data "azuread_users" "managers" {
  user_principal_names = distinct([
    for u in values(local.users) : "${u.manager_key}@${local.upn_domain}"
    if u.manager_key != null
  ])
  ignore_missing = true
}

locals {
  manager_object_ids = {
    for u in data.azuread_users.managers.users : lower(u.user_principal_name) => u.object_id
  }
}

resource "random_password" "initial" {
  for_each = local.users

  length      = 24
  special     = true
  min_lower   = 2
  min_upper   = 2
  min_numeric = 2
  min_special = 2
}

resource "azuread_user" "this" {
  for_each = local.users

  user_principal_name = "${each.key}@${local.upn_domain}"
  mail_nickname       = replace(each.key, ".", "")
  display_name        = "${each.value.given_name} ${each.value.surname}"
  given_name          = each.value.given_name
  surname             = each.value.surname
  employee_id         = each.value.employee_id
  employee_type       = each.value.employee_type
  department          = each.value.department
  job_title           = each.value.job_title
  office_location     = each.value.office_location
  usage_location      = each.value.usage_location
  account_enabled     = each.value.enabled

  manager_id = each.value.manager_key == null ? null : lookup(
    local.manager_object_ids,
    "${each.value.manager_key}@${local.upn_domain}",
    null
  )

  password              = random_password.initial[each.key].result
  force_password_change = true

  lifecycle {
    ignore_changes = [password]
  }
}