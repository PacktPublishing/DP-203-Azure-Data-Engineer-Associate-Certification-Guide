# Creating Azure storage account

$resourceGroup = "<INSERT RESOURCE GROUP NAME>"
$storageAccount ="<INSERT STORAGE ACCOUNT NAME>"
$region = "<INSERT REGION NAME>"

# We will have to create an Azure Storage first before we can create queues, shares or files
az storage account create --resource-group $resourceGroup --name $storageAccount --location $region --kind StorageV2 --sku Standard_LRS