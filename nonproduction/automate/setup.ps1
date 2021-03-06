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
#
$params = @{
    vaults_secrets_name = "mothershipautsecret"
    registries_registry_name = "mothershipautregistry"
    userAssignedIdentities_identity_name = "mothershipautappidentity"
}

$resourceName = "mothership-aut-rg"
$location = "eastus"

New-AzResourceGroup -Name $resourceName -Location $location -Force

New-AzResourceGroupDeployment `
-Mode Incremental `
-Name OwlveyDeployment `
-ResourceGroupName $resourceName `
-TemplateFile ./template/template.json `
-TemplateParameterObject $params `
-Force

$webappname = 'azure-aut-app-' + [GUID]::NewGuid().ToString('N')

New-AzAppServicePlan -Name $webappname -Location $location -ResourceGroupName $resourceName -Tier Free

New-AzWebApp -Name $webappname -Location $location -AppServicePlan $webappname -ResourceGroupName $resourceName

