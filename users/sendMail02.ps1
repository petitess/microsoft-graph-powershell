$filePath = "C:\temp\reolink.pdf"
$fileName = [System.IO.Path]::GetFileName($filePath)
$fileBytes = [System.IO.File]::ReadAllBytes($filePath)
$fileBase64 = [System.Convert]::ToBase64String($fileBytes)

$body = @{
    message = @{
        subject = "Meet for graph api"
        body = @{
            contentType = "Text"
            content     = "Message from graph api"
        }
        toRecipients = @(
            @{
                emailAddress = @{
                    address = "karol.@def.com"
                }
            }
        )
        attachments = @(
            @{
                "@odata.type" = "#microsoft.graph.fileAttachment"
                name          = $fileName
                contentType  = "application/pdf"
                contentBytes = $fileBase64
            }
        )
    }
    saveToSentItems = $false
}

Invoke-MgGraphRequest `
    -Method POST `
    -Uri "/v1.0/users/karol@abc.se/sendMail" `
    -Body $body
