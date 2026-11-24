resource "azuread_administrative_unit" "AU-Standort-Hamburg" {
  display_name            = "AU-Standort-Hamburg"
  description             = "Alle Benutzer am Standort Hamburg. Verwaltet durch Terraform."
  prevent_duplicate_names = true
  members                 = [for k, u in local.users : azuread_user.this[k].object_id if u.office_location == "Hamburg"]
}

resource "azuread_administrative_unit" "AU-Verwaltung" {
  display_name            = "AU-Verwaltung"
  description             = "Abteilung Verwaltung. Verwaltet durch Terraform."
  prevent_duplicate_names = true
  members                 = [for k, u in local.users : azuread_user.this[k].object_id if u.department == "Verwaltung"]
}

resource "azuread_administrative_unit" "AU-Vertrieb" {
  display_name            = "AU-Vertrieb"
  description             = "Abteilung Vertrieb. Verwaltet durch Terraform."
  prevent_duplicate_names = true
  members                 = [for k, u in local.users : azuread_user.this[k].object_id if u.department == "Vertrieb"]
}

resource "azuread_administrative_unit" "AU-Entwicklung" {
  display_name            = "AU-Entwicklung"
  description             = "Abteilung Entwicklung. Verwaltet durch Terraform."
  prevent_duplicate_names = true
  members                 = [for k, u in local.users : azuread_user.this[k].object_id if u.department == "Entwicklung"]
}
