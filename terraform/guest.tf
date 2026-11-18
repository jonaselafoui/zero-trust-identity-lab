resource "azuread_invitation" "guests" {
    for_each    = toset(var.guest_users)
    user_email_address  = each.value
    redirect_url        = "https://portal.azure.com"
}