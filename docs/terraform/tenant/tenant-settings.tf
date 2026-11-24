resource "msgraph_update_resource" "authorization_policy" {
  url = "policies/authorizationPolicy"

  body = {
    allowInvitesFrom  = "adminsAndGuestInviters"
    guestUserRoleId   = "2af84b1e-32c8-42b7-82bc-daa82404023b"
    allowedToUseSSPR  = false
    # Collaboration restrictions only exists in the msgraph beta resource which is subject to change
    # I changed the setting in the Portal for now

    defaultUserRolePermissions = {
      allowedToCreateApps                      = false
      allowedToCreateTenants                   = false
      allowedToCreateSecurityGroups            = false
      allowedToReadOtherUsers                  = true
      allowedToReadBitlockerKeysForOwnedDevice = true
    }
  }
}

resource "msgraph_resource" "group_unified_setting" {
  url = "groupSettings"

  body = {
    templateId = "62375ab9-6b52-47ed-826b-58e47e0e304b"
    values = [
      { name = "EnableGroupCreation", value = "false" },
      { name = "GroupCreationAllowedGroupId", value = azuread_group.staticgroups["SGID0022"].object_id },
      { name = "NewUnifiedGroupWritebackDefault", value = "true" },
      { name = "EnableMIPLabels", value = "false" },
      { name = "CustomBlockedWordsList", value = "" },
      { name = "EnableMSStandardBlockedWords", value = "false" },
      { name = "ClassificationDescriptions", value = "" },
      { name = "DefaultClassification", value = "" },
      { name = "PrefixSuffixNamingRequirement", value = "" },
      { name = "AllowGuestsToBeGroupOwner", value = "false" },
      { name = "AllowGuestsToAccessGroups", value = "true" },
      { name = "GuestUsageGuidelinesUrl", value = "" },
      { name = "AllowToAddGuests", value = "true" },
      { name = "UsageGuidelinesUrl", value = "" },
      { name = "ClassificationList", value = "" },
    ]
  }
}

resource "msgraph_update_resource" "cta_partner" {
  url = "policies/crossTenantAccessPolicy/default"
  body = {
    b2bCollaborationOutbound = {
      usersAndGroups = {
        accessType = "allowed"
        targets = [
          {
            target     = resource.azuread_group.staticgroups["SGID0016"].object_id
            targetType = "group"
          }
        ]
      }
    }
  }
}