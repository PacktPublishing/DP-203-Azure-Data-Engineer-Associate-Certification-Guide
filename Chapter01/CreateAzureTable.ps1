# Creating Azure Table

$resourceGroup = "<INSERT RESOURCE GROUP NAME>"
$storageAccount ="<INSERT STORAGE ACCOUNT NAME>"
$storageKey = "<INSERT STORAGE KEY>"
# Note: It is not recommended to store passwords or access keys in code files.
# Please use AAD accounts and Azure Key Vault to store secrets
$region = "<INSERT REGION NAME>"
$tableName = "<INSERT TABLE NAME>"

#The following variations are accepted for setting the Key:
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


#   We can create a new Azure Table for our example company, IAC, by using the storage table create option:
az storage table create --name $tableName  --account-name $storageAccount
#	We can easily list the Tables under a storage account using the storage table list option:
az storage table list --account-name $storageAccount
# 	We can insert an entity into the newly created Table using the storage entity insert option:
az storage entity insert --table-name $tableName  --entity PartitionKey=testPartKey RowKey=testRowKey Content=testContent
#   Finally, we can use the storage entity show command to view the entry:
az storage entity show --table-name $tableName  --partition-key testPartKey --row-key testRowKey