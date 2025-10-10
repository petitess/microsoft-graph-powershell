$SiteId = "12345678-cef1-47d9-8ba5-ed72bc2b4ddb"
$DriveId = "12345678CtN27UrgykLaeNLpXDgeWZfz47taPBFbhjHQoxOlF6hlQrg"
$ListId = "12345678-186e-42c7-8c4e-945ea1950ae0"
$ItemId = "12345678-106C-450D-80F6-C7BCC409913B"
$DriveItemId = "12345678ZCVWLUVNKZOZORCD32UZX"
$FolderName = "Konkurs/TEST_ABC"
$FilePath = "Konkurs/TEST_ABC/TEST_XYZ.docx"
$Url = "https://graph.microsoft.com/v1.0/sites/$SiteId/drives"
$Url = "https://graph.microsoft.com/v1.0/sites/$SiteId/drives/$DriveId"
$Url = "https://graph.microsoft.com/v1.0/sites/$SiteId/drives/$DriveId/root/children"
$Url = "https://graph.microsoft.com/v1.0/sites/$SiteId/drives/$DriveId/items/$DriveItemId/children"
$Url = "https://graph.microsoft.com/v1.0/sites/$SiteId/drives/$DriveId/root:/$($FolderName):/children"
$Url = "https://graph.microsoft.com/v1.0/sites/$SiteId/drives/$DriveId/root:/$($FilePath):/content"
$Url = "https://graph.microsoft.com/v1.0/sites/$SiteId/lists" 
$Url = "https://graph.microsoft.com/v1.0/sites/$SiteId/lists/$ListId/items" 
$Url = "https://graph.microsoft.com/v1.0/sites/$SiteId/lists/$ListId/items/3667/children" 
# $Url = "https://graph.microsoft.com/v1.0/sites/$SiteId/drives/$DriveId/items/$ItemId/content"
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-type"  = "application/json"
}
$connection = Invoke-RestMethod `
    -Uri $Url `
    -Method GET `
    -Headers $headers
$connection.value | Where-Object webUrl -Match "rekonstruktionslista"
