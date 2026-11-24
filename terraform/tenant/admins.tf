locals {
  admin_accounts = {
    "adm-thomas.becker"  = { owner = "thomas.becker",  tier = 0, scope = "Tenant",              roles = ["Global Administrator"] }
    "adm-lena.vogt"      = { owner = "lena.vogt",      tier = 0, scope = "Tenant",              roles = ["Privileged Role Administrator", "Conditional Access Administrator", "Authentication Policy Administrator"] }
    "adm-julia.krause"   = { owner = "julia.krause",   tier = 1, scope = "Tenant",              roles = ["Application Administrator", "Intune Administrator"] }
    "adm-kevin.schulz"   = { owner = "kevin.schulz",   tier = 2, scope = "Tenant",              roles = ["Helpdesk Administrator"] }
    "adm-mehmet.yilmaz"  = { owner = "mehmet.yilmaz",  tier = 2, scope = "AU-Standort-Hamburg", roles = ["Helpdesk Administrator"] }
    "adm-petra.schmitt"  = { owner = "petra.schmitt",  tier = 2, scope = "AU-Verwaltung",       roles = ["User Administrator"] }
    "adm-felix.richter"  = { owner = "felix.richter",  tier = 2, scope = "AU-Entwicklung",      roles = ["Helpdesk Administrator"] }
    "adm-nina.albrecht"  = { owner = "nina.albrecht",  tier = 2, scope = "AU-Vertrieb",         roles = ["Helpdesk Administrator"] }
  }

  au_ids = {
    "AU-Standort-Hamburg" = azuread_administrative_unit.AU-Standort-Hamburg.object_id
    "AU-Verwaltung"       = azuread_administrative_unit.AU-Verwaltung.object_id
    "AU-Vertrieb"         = azuread_administrative_unit.AU-Vertrieb.object_id
    "AU-Entwicklung"      = azuread_administrative_unit.AU-Entwicklung.object_id
  }

  admin_roles = toset(flatten([for a in values(local.admin_accounts) : a.roles]))

  admin_role_assignments = merge([
    for adm, a in local.admin_accounts : {
      for r in a.roles : "${adm}|${r}" => { admin = adm, role = r, scope = a.scope }
    }
  ]...)
}

resource "random_password" "admin" {
  for_each = local.admin_accounts

  length      = 32
  special     = true
  min_lower   = 2
  min_upper   = 2
  min_numeric = 2
  min_special = 2
}

resource "azuread_user" "admin" {
  for_each = local.admin_accounts

  user_principal_name = "${each.key}@${local.upn_domain}"
  mail_nickname       = replace(each.key, ".", "")
  display_name        = "${local.users[each.value.owner].given_name} ${local.users[each.value.owner].surname} (Admin T${each.value.tier})"
  given_name          = local.users[each.value.owner].given_name
  surname             = local.users[each.value.owner].surname
  employee_type       = "Admin"
  usage_location      = "DE"

  password              = random_password.admin[each.key].result
  force_password_change = true

  lifecycle {
    ignore_changes = [password]

    precondition {
      condition     = contains(keys(local.users), each.value.owner)
      error_message = "Admin ${each.key}: owner '${each.value.owner}' is not in users.csv."
    }
    precondition {
      condition     = each.value.scope == "Tenant" || contains(keys(local.au_ids), each.value.scope)
      error_message = "Admin ${each.key}: unknown scope '${each.value.scope}'."
    }
  }
}

resource "azuread_directory_role" "this" {
  for_each     = local.admin_roles
  display_name = each.key
}

resource "azuread_directory_role_assignment" "admin" {
  for_each = local.admin_role_assignments

  role_id             = azuread_directory_role.this[each.value.role].template_id
  principal_object_id = azuread_user.admin[each.value.admin].object_id
  directory_scope_id  = each.value.scope == "Tenant" ? "/" : "/administrativeUnits/${local.au_ids[each.value.scope]}"
}
