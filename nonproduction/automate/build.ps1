param ($debug = $false)

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

$webappname = 'azure-aut-app-' + [GUID]::NewGuid().ToString('N')

#New-AzAppServicePlan -Name $webappname -Location $location -ResourceGroupName $resourceName -Tier Free
#New-AzWebApp -Name $webappname -Location $location -AppServicePlan $webappname -ResourceGroupName $resourceName
Push-Location "./AzureApp"
docker build -f "./AzureApp/Dockerfile" --force-rm . 
Pop-Location 
#docker login mothershipautregistry.azurecr.io  --username mothershipautregistry --password "BtNM/Yi702JrLJUp=jeil5i4xbg/v+bg"

$env:FirstName = 'Trevor'

