$user1 = (Invoke-MgGraphRequest -Uri "/v1.0/users?`$filter=mail eq 'Dennis.alfredsson@abc.se'").Value.id
$user2 = (Invoke-MgGraphRequest -Uri "/v1.0/users?`$filter=mail eq 'sara.goden@abc.se'").Value.id

(Invoke-MgGraphRequest -Uri "/v1.0/groups?`$filter=startswith(displayName, 'EpiserverAbcPublic-')&`$select=displayName,id").value[0] | ForEach-Object {
    Write-Output "Group Name: $($_.displayName) - Group ID: $($_.id)"

    $body = @{
        "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$user1"
    } | ConvertTo-Json

    $Added1 = Invoke-MgGraphRequest -Method POST -Body $body -Uri "/v1.0/groups/$($_.id)/members/$('$ref')"

    $body = @{
        "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$user2"
    } | ConvertTo-Json

    $Added2 = Invoke-MgGraphRequest -Method POST -Body $body -Uri "/v1.0/groups/$($_.id)/members/$('$ref')"
}
