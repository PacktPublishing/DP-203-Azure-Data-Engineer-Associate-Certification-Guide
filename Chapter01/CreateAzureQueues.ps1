#Creating Azure Queues using the CLI

$resourceGroup = "<INSERT RESOURCE GROUP NAME>"
$storageAccount ="<INSERT STORAGE ACCOUNT NAME>"
$storageKey = "<INSERT STORAGE KEY>"
# Note: It is not recommended to store passwords or access keys in code files.
# Please use AAD accounts and Azure Key Vault to store secrets
$region = "<INSERT REGION NAME>"
$queueName = "<INSERT QUEUE NAME>"

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

#You can create a new Azure queue using the storage queue create command:
az storage queue create --name $queueName --account-name $storageAccount
#You can easily list the queues under a storage account using the storage queue list term:
az storage queue list --account-name $storageAccount
#You can add a new message to the newly created Queue using the storage message put option:
az storage message put --queue-name $queueName --content "test"
#Finally, use the storage message peek command to view the message. This command retrieves one or more messages from the front of the queue but does not alter the visibility of the message:
az storage message peek --queue-name $queueName