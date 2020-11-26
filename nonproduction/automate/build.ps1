$params = @{
    vaults_secrets_name = "mothershipautsecret"
    registries_registry_name = "mothershipautregistry"
    userAssignedIdentities_identity_name = "mothershipuatappidentity"
}

Connect-AzAccount

$resourceName = "mothership-rg"
$location = "eastus"

Set-AzContext 652129d9-5c47-49f8-ba58-0137a903edb0

New-AzResourceGroup -Name $resourceName -Location $location -Force

New-AzResourceGroupDeployment `
-Mode Complete `
-Name OwlveyDeployment `
-ResourceGroupName $resourceName `
-TemplateFile ./../../template.json `
-TemplateParameterObject $params `
-Force

