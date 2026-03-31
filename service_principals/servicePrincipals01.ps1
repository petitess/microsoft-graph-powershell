((Invoke-GraphRequest -Uri "/v1.0/servicePrincipals").value | Where-Object { $_.replyUrls -gt 0 } | Select-Object displayName,replyUrls).Count

(Invoke-GraphRequest -Uri "/v1.0/servicePrincipals?`$select=displayName,replyUrls").value

(Invoke-GraphRequest -Uri "/v1.0/servicePrincipals?`$filter=displayName eq 'eFront'").value.replyUrls
