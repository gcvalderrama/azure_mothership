$clientId = ($env:credentials | ConvertFrom-Json).clientId
$clientSecret = ($env:credentials | ConvertFrom-Json).clientSecret | ConvertTo-SecureString -AsPlainText -Force
$tenantId = ($env:credentials | ConvertFrom-Json).tenantId
$credentials = New-Object System.Management.Automation.PSCredential($clientId, $clientSecret)

$connected = Connect-AzAccount -ServicePrincipal -Credential $credentials -Tenant $tenantId

Set-AzContext -SubscriptionId "652129d9-5c47-49f8-ba58-0137a903edb0" -Force

$params = @{
    vaults_secrets_name = "mothershipprodsecret"
    registries_registry_name = "mothershipprodregistry"
    userAssignedIdentities_identity_name = "mothershipappidentity"
}

$resourceName = "mothership-rg"
$location = "eastus"
New-AzResourceGroup -Name $resourceName -Location $location -Force

New-AzResourceGroupDeployment `
-Mode Complete `
-Name mothershipProdDeployment `
-ResourceGroupName $resourceName `
-TemplateFile ./template/template.json `
-TemplateParameterObject $params `
-Force