param
(     
      [Parameter(Mandatory=$true)]
      $namePrefix
)

$rg = "rg-$namePrefix"

"Get Subscription"
$sub = az account show --query 'id' --out tsv

"Get Credentials"
az aks get-credentials --resource-group $rg --subscription $sub --name ("aks-ContosoTravel-" + $namePrefix) --overwrite-existing

"Get Info From Resource Group - identity"
$id = az identity list --query [].id --output tsv  --resource-group $rg --subscription $sub
"Get Info From Resource Group - clientId"
$clientId = az identity list --query [].clientId --output tsv  --resource-group $rg --subscription $sub

# Get the id of the service principal configured for AKS and Resource Id
$CLIENT_ID=(az aks show --resource-group $rg --subscription $sub --name ("aks-ContosoTravel-" + $namePrefix) --query "servicePrincipalProfile.clientId" --output tsv)
$RESOURCE_ID=(az aks show --resource-group $rg --subscription $sub --name ("aks-ContosoTravel-" + $namePrefix) --query "id" --output tsv)

# Get the ACR registry resource id
$ACR_ID=$(az acr show --name ("acrContosoTravel" + $namePrefix) --resource-group $rg --subscription $sub --query "id" --output tsv)

# Create role assignment to pull container
az role assignment create --assignee $CLIENT_ID --role acrpull --scope $ACR_ID

# Create role assignment to public Monitoring Metrics
az role assignment create --assignee $CLIENT_ID --role "Monitoring Metrics Publisher" --scope $RESOURCE_ID

function replaceInFiles([string]$fileName) {
  $contents = get-content $fileName | out-string
  $contents = $contents.Replace('$CLIENTID$', $clientId)
  $contents = $contents.Replace('$ID$', $id)
  set-content -Path $fileName -Value $contents -Force
}

kubectl create -f https://raw.githubusercontent.com/Azure/aad-pod-identity/master/deploy/infra/deployment.yaml
replaceInFiles "$PSScriptRoot/init.yaml"
kubectl apply -f "$PSScriptRoot/init.yaml"


