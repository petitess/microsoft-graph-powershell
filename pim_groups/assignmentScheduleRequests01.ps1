##PrivilegedEligibilitySchedule.ReadWrite.AzureADGroup PrivilegedAccess.ReadWrite.AzureADGroup
##Active assigment
$Script = ConvertTo-Json @{
    accessId      = "member"
    principalId   = "12345678-d09d-476e-b0b1-eaada594528e"
    groupId       = "12345678-d741-469e-a3e4-ddcf6462be62"
    action        = "adminAssign"
    scheduleInfo  = @{
        expiration = @{ 
            type     = "afterDuration"
            duration = "PT2H" 
        } 
    }
    justification = "Assign active member access"
}

Invoke-MgGraphRequest -Uri "/v1.0/identityGovernance/privilegedAccess/group/assignmentScheduleRequests" -Method POST -Body $Script

##Eligible assigment
$Script = ConvertTo-Json @{
    accessId      = "member"
    principalId   = "12345678-d09d-476e-b0b1-eaada594528e"
    groupId       = "12345678-d741-469e-a3e4-ddcf6462be62"
    action        = "adminAssign"
    memberType    = "direct"
    scheduleInfo  = @{
        expiration = @{ 
            type        = "noExpiration" #Must adjust the policy first
            duration    = $null 
            endDateTime = $null 
        } 
    }
    justification = "Assign active member access"
}

Invoke-MgGraphRequest -Uri "/v1.0/identityGovernance/privilegedAccess/group/eligibilityScheduleRequests" -Method POST -Body $Script

##Get assigments for a group
(Invoke-MgGraphRequest -Uri "/v1.0/identityGovernance/privilegedAccess/group/eligibilitySchedules?`$filter=groupId eq '12345678-4ce9-a248-9815a0f0917d'").value | ConvertTo-Json -Depth 100
