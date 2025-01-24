import random
from azure.identity import AzureCliCredential
from azure.mgmt.storage import StorageManagementClient

#Credntial
credential = AzureCliCredential()

# Subscription Id
subscription_id = 'b8c2d409-2ec8-4a3c-9faf-9b4a543e3649'
resource_group_name = "rg-prateek-sandbox-test"
storage_account_name = "prateekstorageaccount"

# Storage Management Client
storage_client = StorageManagementClient(credential, subscription_id)

# check if the storage account name is available
try:
    while True:
        storage_account_random_name = f'{storage_account_name}{random.randint(1,1000)}'
        if not storage_client.storage_accounts.check_name_availability(storage_account_random_name):
            print(f'storage account name {storage_account_random_name} is not available, trying again')
        else:
            print(f'storage account name {storage_account_random_name} is available')
            break
except Exception as e:   
    print(f"Error: {e}")

try:
    storage_create_result = storage_client.storage_accounts.begin_create(
        resource_group_name=resource_group_name,
        account_name= storage_account_name,
        parameters={
            "sku": {
                "name": "Standard_LRS"
            },
            "kind": "storageV2",
            "location": "eastus"
        }
        )
except Exception as e:   
    print(f"Error: {e}")



