#PrivilegedEligibilitySchedule.ReadWrite.AzureADGroup PrivilegedAccess.ReadWrite.AzureADGroup
#Get PIM policies
$PimPolicies = (Invoke-MgGraphRequest -Uri "/v1.0/policies/roleManagementPolicies?`$filter=scopeId eq '12345678-2768-4ce9-a248-9815a0f0917d' and scopeType eq 'Group'").value # | ConvertTo-Json
$PimPolicies = (Invoke-MgGraphRequest -Uri "/v1.0/policies/roleManagementPolicies?`$filter=scopeId eq '12345678-d741-469e-a3e4-ddcf6462be62' and scopeType eq 'Group'").value # | ConvertTo-Json

$PimPolicies | ForEach-Object {
    #Get PIM policy rules
    $PolicyId = $_.id
    $PimRules = (Invoke-MgGraphRequest -Uri "/v1.0/policies/roleManagementPolicies/$($_.id)/rules").value #| ConvertTo-Json -Depth 100 #| Out-File PIM-rules-maxa.json
    # $PimRules.id
    $PimRules | Where-Object id -Like "Notification*" | ForEach-Object {
        # $_.id
        #Disable Notifications
        $_.isDefaultRecipientsEnabled = $false
        $Body = $_ | ConvertTo-Json -Depth 20
        Invoke-MgGraphRequest -Uri "/v1.0/policies/roleManagementPolicies/$($PolicyId)/rules/$($_.id)" -Method PATCH -Body $Body
    }

    $PimRules | Where-Object id -Like "Expiration_Admin_Eligibility" | ForEach-Object {
        # $_.id
        #Disable Expiration for owner
        $_.isExpirationRequired = $false
        $_.maximumDuration = "PT12H"
        $Body = $_ | ConvertTo-Json -Depth 20
        Invoke-MgGraphRequest -Uri "/v1.0/policies/roleManagementPolicies/$($PolicyId)/rules/$($_.id)" -Method PATCH -Body $Body
    }

    $PimRules | Where-Object id -Like "Expiration_EndUser_Assignment" | ForEach-Object {
        # $_.id
        #Disable Expiration for member
        $_.isExpirationRequired = $false
        $_.maximumDuration = "PT12H"
        $Body = $_ | ConvertTo-Json -Depth 20
        Invoke-MgGraphRequest -Uri "/v1.0/policies/roleManagementPolicies/$($PolicyId)/rules/$($_.id)" -Method PATCH -Body $Body
    }
}
