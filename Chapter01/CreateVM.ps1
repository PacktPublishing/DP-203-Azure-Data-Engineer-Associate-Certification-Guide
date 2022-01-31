## Creating VM

$resourceGroup = "<INSERT RESOURCE GROUP NAME>"
$region = "<INSERT REGION NAME>"


$vmName = "sampleVM"
$password = "<INSERT SAMPLE PASSWORD>" 
# Note: It is not recommended to store passwords or access keys in code files.
# Please use AAD accounts and Azure Key Vault to store secrets

$image = "UbuntuLTS"
$diskName = "sampleDisk"
$subnetName = "sampleSubnet"
$pubIpName = "samplePubIp"
$vnetName = "sampleVnet"
$nicName = "sampleNIC"

# First, we have to find all the Ubuntu images that are available using the vm image list option:
az vm image list --all --offer Ubuntu --all
# Next, we need to find the Azure regions where we want to deploy. We can use account list-locations for this. You can choose a region that is closest to you:
az account list-locations --output table

# Once we’ve done this, we can either create a new resource group or use an existing one to associate this VM with. You can create a new resource group using the group create option, as shown here:
az group create --name $resourceGroup --location $region

# Finally, we can create a VM using the information from the preceding commands. In this example, I’ve chosen the eastus location to deploy this VM to. All the non-mandatory fields will default to the Azure default values:
az vm create --resource-group $resourceGroup --name $vmName --image $image --admin-username  --admin-password $password --location $region

## Creating and attaching Managed Disks to a VM using the CLI
az vm disk attach --resource-group $resourceGroup --vm-name $vmName --name $diskName --size-gb 64 -new

## Creating an Azure VNet using the CLI
# First, we need to create a VNET by specifying the necessary IP ranges and subnet prefixes:
az network vnet create --address-prefixes 10.20.0.0/16 --name $vnetName --resource-group $resourceGroup --subnet-name $subnetName  --subnet-prefixes 10.20.0.0/24
# Then, we need to create a public IP so that we can access our VM from the internet:
az network public-ip create --resource-group $resourceGroup --name $pubIpName --allocation-method dynamic
# Next, we must create a network interface card (NIC), which will be the network interface between the VM and the outside world, with the previously created VNet and public IP:
az network nic create --resource-group $resourceGroup --vnet-name $vnetName --subnet $subnetName  --name $nicName --public-ip-address $pubIpName
# We now have all the components required to create a VM within our new VNet, IACVnet. We can reuse the UbuntuLTS image that we used in the earlier virtual machine creation example to create a new VM within the new Vnet:
az vm create --resource-group $resourceGroup --name $vmName  --nics $nicName --image $image --generate-ssh-keys
