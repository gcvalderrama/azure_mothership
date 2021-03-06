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
az appservice plan create --name AppSvc-DockerTutorial-plan --resource-group AppSvc-DockerTutorial-rg --is-linux
#New-AzAppServicePlan -Name $webappname -Location $location -ResourceGroupName $resourceName -Tier Free
#New-AzWebApp -Name $webappname -Location $location -AppServicePlan $webappname -ResourceGroupName $resourceName
#$env:REGISTRY_AUT_PASSWORD | docker login mothershipautregistry.azurecr.io -u $env:REGISTRY_AUT_USERNAME --password-stdin 
#Push-Location "./AzureApp"
#$tag  = "$env:git_ref-$env:git_number-$env:git_sha"
#docker build -f "./AzureApp/Dockerfile" --force-rm . -t mothershipautregistry.azurecr.io/azureapp:$tag
#docker push mothershipautregistry.azurecr.io/azureapp:$tag
#Pop-Location 

[System.Environment]::SetEnvironmentVariable('FirstName','docker.artofshell.com')

