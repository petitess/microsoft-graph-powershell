#Mail.Send

$body = @{
    "message"         = @{
        "subject"      = "Meet for graph api"
        "body"         = @{
            "contentType" = "Text"
            "content"     = "Message from graph api"
        }
        "toRecipients" = @(
            @{
                "emailAddress" = @{
                    "address" = "karol@abc.com"
                }
            }
        )
    }
    "saveToSentItems" = "false"
}
Invoke-MgGraphRequest -Method POST -Uri "/v1.0/users/karol@def.se/sendMail" -Body $body
