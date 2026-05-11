# https://learn.microsoft.com/en-us/graph/api/rbacapplication-post-roleassignmentschedulerequests?view=graph-rest-1.0&tabs=http
#RoleAssignmentSchedule.ReadWrite.Directory 	
#Doesnt work with MFA
$roleName = 'Teams Administrator'
$upn = "karol@abc.onmicrosoft.com"
$roleId =(Invoke-MgGraphRequest -Uri "/v1.0/roleManagement/directory/roleDefinitions?`$filter = displayName eq '$roleName'").value.id
$userId = (Invoke-MgGraphRequest -Uri "/v1.0/users?`$filter=startswith(userPrincipalName, '$upn')&`$select=id").value.id

$body = @{
    "action" = "selfActivate"
    "justification" = "activated_by_pipeline"
    "roleDefinitionId" = $roleId
    "directoryScopeId" = "/"
    "principalId" = $userId
    "scheduleInfo" = @{
        "startDateTime" = (Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffZ")
        "expiration" = @{
            "type" = "afterDuration"
            "duration" = "PT8H"  # ISO 8601 duration (8 hours)
        }
    }
    ticketInfo= @{
        "ticketNumber"= $null
        "ticketSystem"= $null
    }
} | ConvertTo-Json -Depth 5

Invoke-MgGraphRequest -Method POST -Uri "/v1.0/roleManagement/directory/roleAssignmentScheduleRequests" -Body $body
