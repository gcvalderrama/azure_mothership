$params = @{
    vaults_secrets_name = "mothershipuatsecret"
    registries_registry_name = "mothershipuatregistry"
    userAssignedIdentities_identity_name = "mothershipuatappidentity"
}

Connect-AzAccount

$resourceName = "mothership-uat-rg"
$location = "eastus"

New-AzResourceGroup -Name $resourceName -Location $location -Force

New-AzResourceGroupDeployment `
-Mode Complete `
-Name OwlveyDeployment `
-ResourceGroupName $resourceName `
-TemplateFile ./../../template.json `
-TemplateParameterObject $params `
-Force

