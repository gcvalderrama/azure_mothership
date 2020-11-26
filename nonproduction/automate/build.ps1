$params = @{
    vaults_secrets_name = "mothershipautsecret"
    registries_registry_name = "mothershipautregistry"
    userAssignedIdentities_identity_name = "mothershipuatappidentity"
}

Connect-AzAccount

$resourceName = "mothership-aut-rg"
$location = "eastus"

New-AzResourceGroup -Name $resourceName -Location $location -Force

New-AzResourceGroupDeployment `
-Mode Complete `
-Name OwlveyDeployment `
-ResourceGroupName $resourceName `
-TemplateFile ./../../template.json `
-TemplateParameterObject $params `
-Force

