#Application.ReadWrite.OwnedBy Application.ReadWrite.All
$AppRegObjectId = "8cffb11c-ff12-432a-911b-c7f5a1e39cfe"
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-type"  = "application/json"
}

$body = @{
    passwordCredential = @{
        displayName = "My New Password"
        endDateTime = (Get-Date).AddYears(30).ToString("o")
        startDateTime = (Get-Date).ToString("o")
    }
}
# Invoke-GraphRequest -Method GET -Uri "v1.0/applications/$AppRegObjectId" -Headers $headers
Invoke-GraphRequest -Method POST -Uri "v1.0/applications/$AppRegObjectId/addPassword" -Headers $headers -Body ($body | ConvertTo-Json -Depth 10)
