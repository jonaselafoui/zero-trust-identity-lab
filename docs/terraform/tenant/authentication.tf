resource "msgraph_update_resource" "fido2_passkey_policy" {
    url = "policies/authenticationMethodsPolicy/authenticationMethodConfigurations/fido2"

    body = {
        state                               = "enabled"
        isSelfServiceRegistrationAllowed    = true

        includeTargets = [
            {
                targetType              = "group"   
                id                      = "all_users"
                isRegistrationRequired  = false
                allowedPasskeyProfiles  = ["00000000-0000-0000-0000-000000000001"]
            }
        ]

        excludeTargets = []

        passkeyProfiles = [
            {
                id                      = "00000000-0000-0000-0000-000000000001"
                name                    = "Default passkey profile"
                passkeyTypes            = "deviceBound,synced"
                attestationEnforcement  = "disabled"
                keyRestrictions = {
                    isEnforced      = false
                    enforcementType = "allow"
                    aaGuids         = []
                }
            }
        ]
    }
}