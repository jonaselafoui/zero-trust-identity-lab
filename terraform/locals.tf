locals {
  upn_domain = lower(data.azuread_domains.default.domains[0].domain_name)

  users_raw = csvdecode(file("${path.module}/users.csv"))

  users = {
    for row in local.users_raw : lower(trimspace(row.upn_prefix)) => {
      employee_id     = trimspace(row.employee_id)
      given_name      = trimspace(row.given_name)
      surname         = trimspace(row.surname)
      department      = trimspace(row.department)
      team            = trimspace(row.team) # used for groups in the next lesson
      job_title       = trimspace(row.job_title)
      office_location = trimspace(row.office_location)
      employee_type   = trimspace(row.employee_type)
      manager_key     = trimspace(row.manager_upn_prefix) == "" ? null : lower(trimspace(row.manager_upn_prefix))
      enabled_raw     = lower(trimspace(row.account_enabled))
      enabled         = lower(trimspace(row.account_enabled)) == "true"
      usage_location  = "DE"
    }
  }

  sggroups_raw = csvdecode(file("${path.module}/sggroups.csv"))

  staticsggroups = {
    for row in local.sggroups_raw : trimspace(row.sggroupID) => {
      display_name  = trimspace(row.display_name)
      team          = trimspace(row.team)
      employee_type = trimspace(row.employee_type)
    } if trimspace(row.rule_attribute) == ""
  }

  dynamicsggroups = {
    for row in local.sggroups_raw : trimspace(row.sggroupID) => {
      display_name = trimspace(row.display_name)
      rule_attribute = trimspace(row.rule_attribute)
      rule_value = trimspace(row.rule_value)
    } if trimspace(row.rule_attribute) != ""
  }

}
