$User = 'x-bcb9-7ba91c64e58d'
$GrpName = 'grp-graph-01'

if (!(Get-MgGroup -Filter "DisplayName eq '$GrpName'")) {
    Write-Output "Creating $GrpName"
    $GrpId = (New-MgGroup -DisplayName $GrpName -MailNickName $GrpName -MailEnabled:$False -SecurityEnabled).Id
    New-MgGroupMember -GroupId $GrpId -DirectoryObjectId $User
}
else {
    Write-Output "$GrpName already exists"
    $GrpId = (Get-MgGroup -Filter "DisplayName eq '$GrpName'").Id

    if ($GrpId.Count -gt 1) {
        Write-Output "More than 1 group with this name exists"
    }
    else {
        if (!(Get-MgGroupMember -GroupId $GrpId -Filter "Id eq '$User'")) {
            Write-Output "Adding member to $GrpName"
            New-MgGroupMember -GroupId $GrpId -DirectoryObjectId $User
        }
        else {
            Write-Output "Member already added to $GrpName"
        }
    }
}
