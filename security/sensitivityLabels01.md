```powershell
#SensitivityLabels.Read.All
Invoke-MgGraphRequest -Uri "/v1.0/security/dataSecurityAndGovernance/sensitivityLabels" | ConvertTo-Json -Depth 100
```
```powershell
{
  "value": [
    {
      "isEnabled": true,
      "locale": null,
      "rights": null,
      "id": "f9af289c-1a47-48f2-add4-1fedd590cb91",
      "isScopedToUser": null,
      "customSettings": [
        {
          "value": "False",
          "name": "isparent"
        }
      ],
      "sublabels@odata.context": "https://graph.microsoft.com/v1.0/$metadata#security/dataSecurityAndGovernance/sensitivityLabels('f9af289c-1a47-48f2-add4-1fedd590cb91')/sublabels",
      "name": "Publikt",
      "hasProtection": false,
      "priority": 0,
      "applicationMode": null,
      "isEndpointProtectionEnabled": false,
      "actionSource": "manual",
      "isSmimeEncryptEnabled": null,
      "applicableTo": "email,file",
      "isSmimeSignEnabled": null,
      "assignedPolicies": [],
      "description": "",
      "isDefault": false,
      "autoTooltip": "",
      "labelActions": [],
      "toolTip": "Information som är avsedd för allmän spridning och inte innebär någon risk om den delas utanför företaget, som exempelvis pressmeddelanden, jobbannonser och offentliga tillkännagivanden.",
      "displayName": null,
      "sublabels": [],
      "color": "#13A10E"
    },
    {
      "isEnabled": true,
      "locale": null,
      "rights": null,
      "id": "a7fcc37b-eed9-4de4-ab39-2524583346ce",
      "isScopedToUser": null,
      "customSettings": [
        {
          "value": "False",
          "name": "isparent"
        }
      ],
      "sublabels@odata.context": "https://graph.microsoft.com/v1.0/$metadata#security/dataSecurityAndGovernance/sensitivityLabels('a7fcc37b-eed9-4de4-ab39-2524583346ce')/sublabels",
      "name": "Internt",
      "hasProtection": false,
      "priority": 1,
      "applicationMode": null,
      "isEndpointProtectionEnabled": true,
      "actionSource": "manual",
      "isSmimeEncryptEnabled": null,
      "applicableTo": "email,file",
      "isSmimeSignEnabled": null,
      "assignedPolicies": [],
      "description": "",
      "isDefault": false,
      "autoTooltip": "",
      "labelActions": [],
      "toolTip": "Information som endast är avsedd för användning inom Abcd eller kan delas med betrodda partners och kunder. Exempel är mötesagendor, interna uppdateringar och policydokument utan känsliga detaljer, som generellt inte bör spridas till externa parter.",
      "displayName": null,
      "sublabels": [],
      "color": "#EAA300"
    },
    {
      "isEnabled": true,
      "locale": null,
      "rights": null,
      "id": "7d2725ad-6ae6-4a4c-a2b4-76af0d1672ba",
      "isScopedToUser": null,
      "customSettings": [
        {
          "value": "False",
          "name": "isparent"
        }
      ],
      "sublabels@odata.context": "https://graph.microsoft.com/v1.0/$metadata#security/dataSecurityAndGovernance/sensitivityLabels('7d2725ad-6ae6-4a4c-a2b4-76af0d1672ba')/sublabels",
      "name": "Konfidentiellt",
      "hasProtection": false,
      "priority": 2,
      "applicationMode": null,
      "isEndpointProtectionEnabled": true,
      "actionSource": "manual",
      "isSmimeEncryptEnabled": null,
      "applicableTo": "email,file",
      "isSmimeSignEnabled": null,
      "assignedPolicies": [],
      "description": "",
      "isDefault": false,
      "autoTooltip": "",
      "labelActions": [],
      "toolTip": "Känslig information som kräver skydd men som kan delas med en specifik betrodd grupp av personer. Exempel är finansiella rapporter, personuppgifter (ej känsliga) och interna strategiska planer och där obehörig åtkomst kan orsaka viss skada men inte allvarlig skada för Abcd, våra anställda eller våra kunder.",
      "displayName": null,
      "sublabels": [],
      "color": "#F7630C"
    },
    {
      "isEnabled": true,
      "locale": null,
      "rights": null,
      "id": "ac3814ad-025c-4544-8dbd-8950fdb817b9",
      "isScopedToUser": null,
      "customSettings": [
        {
          "value": "False",
          "name": "isparent"
        }
      ],
      "sublabels@odata.context": "https://graph.microsoft.com/v1.0/$metadata#security/dataSecurityAndGovernance/sensitivityLabels('ac3814ad-025c-4544-8dbd-8950fdb817b9')/sublabels",
      "name": "Sekretess",
      "hasProtection": true,
      "priority": 5,
      "applicationMode": null,
      "isEndpointProtectionEnabled": true,
      "actionSource": "manual",
      "isSmimeEncryptEnabled": null,
      "applicableTo": "email,file",
      "isSmimeSignEnabled": null,
      "assignedPolicies": [],
      "description": "",
      "isDefault": false,
      "autoTooltip": "",
      "labelActions": [],
      "toolTip": "Mycket känslig information där obehörig åtkomst kan leda till stor skada för Abcd, våra kunder eller anställda. Exempel är företagshemligheter, känslig kundinformation (eller större mänga kundinformation), känsliga personuppgifter eller annan säkerhetskänslig information. Informationen delas endast med personer som absolut behöver tillgång och alltid med lämpliga säkerhetsåtgärder (Informationen kommer inte lämna Abcds IT miljö).",
      "displayName": null,
      "sublabels": [],
      "color": "#A4262C"
    }
  ],
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#security/dataSecurityAndGovernance/sensitivityLabels"
}
```
