data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
    client_id = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
}

locals {
    graph_app_permissions = [
        "Policy.ReadWrite.AuthenticationMethod",
        "Policy.ReadWrite.Authorization",
        "Policy.ReadWrite.CrossTenantAccess",
        "Directory.ReadWrite.All"
    ]
}


resource "azuread_application" "terraform" {
    display_name = "terraform-entra"

    required_resource_access {
        resource_app_id = data.azuread_service_principal.msgraph.client_id

        dynamic "resource_access" {
            for_each = local.graph_app_permissions
            content {
                id      = data.azuread_service_principal.msgraph.app_role_ids[resource_access.value]
                type    = "Role"
            }
        }
    }
}

resource "azuread_service_principal" "terraform" {
    client_id = azuread_application.terraform.client_id
}

resource "azuread_app_role_assignment" "graph" {
  for_each = toset(local.graph_app_permissions)

  app_role_id         = data.azuread_service_principal.msgraph.app_role_ids[each.value]
  principal_object_id = azuread_service_principal.terraform.object_id
  resource_object_id  = data.azuread_service_principal.msgraph.object_id
}

data "azurerm_storage_account" "tfstate" {
  name                = "tfstate30274"
  resource_group_name = "tfstate"
}

resource "azurerm_role_assignment" "tenant_state" {
  scope                = "${data.azurerm_storage_account.tfstate.id}/blobServices/default/containers/tfstate"
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.terraform.object_id
}