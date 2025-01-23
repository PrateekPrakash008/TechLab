import os
from azure.identity import DefaultAzureCredential
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.resource import FeatureClient

# Authentication
credential = DefaultAzureCredential()

# Get the subscription ID from environment variables
subscription_id = os.getenv("TF_VAR_SUB_ID")

# Initialize ResourceManagementClient
resource_client = ResourceManagementClient(credential, subscription_id)

# Initialize FeatureClient
client = FeatureClient(credential, subscription_id)

# Provider namespaces to register
provider_namespaces = [
    "Microsoft.SqlVirtualMachine"
]

# Register providers
for namespace in provider_namespaces:
    try:
        result = resource_client.providers.register(namespace)
        print(f"ProviderNamespace: {result.namespace}, RegistrationState: {result.registration_state}")
    except Exception as e:
        print(f"Failed to register provider: {namespace}")
        print(f"Error: {e}")

# Register provider feature
try:
    feature_result = client.features.register(
        resource_provider_namespace="Microsoft.SqlVirtualMachine",
        feature_name="BulkRegistration",
    )
    print(feature_result)
except Exception as e:
    print(f"Error: {e}")
