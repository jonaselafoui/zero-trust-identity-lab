provider "azuread" {
  tenant_id = var.tenant_id
}

# Tells you which identity Terraform is running as. Useful for auditing and owners.
data "azuread_client_config" "current" {}

# Looks up the tenant's domains so UPNs aren't hardcoded
data "azuread_domains" "default" {
  only_initial = true # the *.onmicrosoft.com domain
}