import os
from azure.identity import DefaultAzureCredential
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.resource import FeatureClient

# Authentication
credential = DefaultAzureCredential()

# List of subscription IDs
subscription_ids = [
    "6810fc64-6016-4728-9d87-4536b5c998c2",
    "dc4bccad-9deb-41d1-aa9b-22d46bd3d67d",
    "53dedb16-780b-4a3c-b1a7-ac939e78d02c"
]

# Provider namespaces to register
provider_namespaces = [
    "Microsoft.SqlVirtualMachine"
]

for subscription_id in subscription_ids:
    print(f"Processing subscription: {subscription_id}")
    
    try:
        # Initialize ResourceManagementClient
        resource_client = ResourceManagementClient(credential, subscription_id)
        
        # Initialize FeatureClient
        client = FeatureClient(credential, subscription_id)
        
        # Register providers
        for namespace in provider_namespaces:
            try:
                result = resource_client.providers.register(namespace)
                print(f"ProviderNamespace: {result.namespace}, RegistrationState: {result.registration_state}")
            except Exception as e:
                print(f"Failed to register provider: {namespace} in subscription: {subscription_id}")
                print(f"Error: {e}")
        
        # Register provider feature
        try:
            feature_result = client.features.register(
                resource_provider_namespace="Microsoft.SqlVirtualMachine",
                feature_name="BulkRegistration",
            )
            print(f"Feature registration result: {feature_result}")
            print("Moving to the next subscription...")
            print("\n")
        except Exception as e:
            print(f"Failed to register feature in subscription: {subscription_id}")
            print(f"Error: {e}")
            print("\n")
    
    except Exception as e:
        print(f"Failed to process subscription: {subscription_id}")
        print(f"Error: {e}")
