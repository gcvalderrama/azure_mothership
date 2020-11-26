# Install-Module -Name Az -AllowClobber -Scope CurrentUser
Import-Module Az.Resources
$params = @{
    vaults_secrets_name = "mothershipprodsecret"
    registries_registry_name = "mothershipprodregistry"
    userAssignedIdentities_identity_name = "mothershipappidentity"
}

Connect-AzAccount

Set-AzContext 652129d9-5c47-49f8-ba58-0137a903edb0
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