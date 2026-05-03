#https://learn.microsoft.com/en-us/graph/api/privilegedaccessgroup-post-assignmentschedulerequests?view=graph-rest-1.0&tabs=http
#PrivilegedAssignmentSchedule.ReadWrite.AzureADGroup
$userId = (Invoke-MgGraphRequest -Uri "/v1.0/users?`$filter=startswith(userPrincipalName, 'karol@abc.onmicrosoft.com')&`$select=id").value.id
$groupId = (Invoke-MgGraphRequest -Uri "/v1.0/groups?`$filter=startswith(displayName, 'grp-az-mg-root-Owner')&`$select=id").value.id

if ($null -ne $groupId) {
    $today = "$(Get-Date -Format "yyyy-MM-dd")"
    $body = @{
        "accessId"      = "member" 
        "principalId"   = $userId
        "groupId"       = $groupId
        "action"        = "adminAssign" 
        "scheduleInfo"  = @{ 
            "startDateTime" = "$(Get-Date -Format "yyyy-MM-ddThh:mm:ssK")"
            "expiration"    = @{ 
                "type"     = "afterDuration" 
                "duration" = "PT10H" 
            } 
        } 
        "justification" = "assign_by_script_$today"
    }
    #Activate
    Invoke-MgGraphRequest -Method POST -Uri "/v1.0/identityGovernance/privilegedAccess/group/assignmentScheduleRequests" -Body $body
}
#Get
(Invoke-MgGraphRequest -Uri "/v1.0/identityGovernance/privilegedAccess/group/assignmentScheduleRequests?`$filter=groupId eq '$groupId' and startswith(justification, 'assign_by_script_$today')").value.id
#Remove
(Invoke-MgGraphRequest -Method DELETE -Uri "/v1.0/groups/$($groupId)/members/$($userId)/$('$ref')")
