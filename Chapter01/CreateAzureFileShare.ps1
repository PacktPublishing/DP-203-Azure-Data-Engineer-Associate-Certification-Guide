#Creating Azure File shares

$resourceGroup = "<INSERT RESOURCE GROUP NAME>"
$storageAccount ="<INSERT STORAGE ACCOUNT NAME>"
$storageKey = "<INSERT STORAGE KEY>"
# Note: It is not recommended to store passwords or access keys in code files.
# Please use AAD accounts and Azure Key Vault to store secrets
$region = "<INSERT REGION NAME>"
$fileshareName = "<INSERT FILE SHARE NAME>"


#   The following variations are accepted for setting the Key:
#   (1) account name and key (--account-name and --account-key options or
#       set AZURE_STORAGE_ACCOUNT and AZURE_STORAGE_KEY environment variables)
#    (2) account name and SAS token (--sas-token option used with either the --account-name
#        option or AZURE_STORAGE_ACCOUNT environment variable)
#    (3) account name (--account-name option or AZURE_STORAGE_ACCOUNT environment variable;
#        this will make calls to query for a storage account key using login credentials)
#    (4) connection string (--connection-string option or
#        set AZURE_STORAGE_CONNECTION_STRING environment variable); some shells will require
#        quoting to preserve literal character interpretation.

# NOTE: The following env variable syntax works for Powershell on Windows. You might have to set the env variables differently for other OS.
$env:AZURE_STORAGE_ACCOUNT=$storageAccount
$env:AZURE_STORAGE_KEY=$storageKey

#You can create a new Azure File Share for IAC using the share-rm create option:
az storage share-rm create --resource-group $resourceGroup --storage-account $storageAccount --name $fileshareName --quota 1024
#You can list the file shares using the share list option:
az storage share list --account-name $storageAccount
#You can put a file into our File share using the file upload option:
az storage file upload --share-name $fileshareName --source Data/testfile.txt
#You can view the files in your File share using file list:
az storage file list --share-name $fileshareName
#Finally, you can download the file that we previously uploaded using the file download option:
az storage file download --share-name $fileshareName -p testfile.txt --dest ./testfile.txt