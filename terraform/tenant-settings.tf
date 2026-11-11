resource "msgraph_update_resource" "authorization_policy" {
  url = "policies/authorizationPolicy"

  body = {
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
