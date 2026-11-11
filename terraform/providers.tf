provider "azuread" {
  tenant_id = var.tenant_id
}

provider "msgraph" {
  tenant_id = var.tenant_id
}

data "azuread_client_config" "current" {}

data "azuread_domains" "default" {
  only_initial = true
}
