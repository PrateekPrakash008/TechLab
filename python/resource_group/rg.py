from azure.identity import AzureCliCredential
from azure.mgmt.resource import ResourceManagementClient

#Credntial
credential = AzureCliCredential()

# Subscription Id
subscription_id = 'b8c2d409-2ec8-4a3c-9faf-9b4a543e3649'
resource_group_name = "rg-prateek-sandbox-test"

# Initialize Resource Management Client
resource_client = ResourceManagementClient(credential, subscription_id)

# Create Resource Group 
resource_group = resource_client.resource_groups.create_or_update(
    resource_group_name = resource_group_name,
    parameters={
        "location" : "west Europe",
        "tags": {
            "environment": "sandbox",
            "createdfor": "learning"
        }
    }
)

# Print the resource group name and location
print(f'resource group: {resource_group.name} in location: {resource_group.location} has been created')

# Delete Resource Group
resource_group_delete = resource_client.resource_groups.begin_delete(resource_group_name=resource_group_name)

# Wait for the delete operation to complete
resource_group_delete.wait()

# Print the status of the delete operation
print(f'resource group has been deleted')