param($debug=$false)
if ( $debug -ne $true ){
    $clientId = ($env:credentials | ConvertFrom-Json).clientId
    $clientSecret = ($env:credentials | ConvertFrom-Json).clientSecret | ConvertTo-SecureString -AsPlainText -Force
    $tenantId = ($env:credentials | ConvertFrom-Json).tenantId
    $credentials = New-Object System.Management.Automation.PSCredential($clientId, $clientSecret)    
    $connected = Connect-AzAccount -ServicePrincipal -Credential $credentials -Tenant $tenantId
}
else{
    Connect-AzAccount
}

Set-AzContext -SubscriptionId "652129d9-5c47-49f8-ba58-0137a903edb0" -Force

$resourceName = "mothership-aut-rg"
$location = "eastus"

$number = "dev49"
$principalId = az webapp identity assign --name $number --resource-group 'mothership-aut-rg' -o tsv --query "principalId" 


