import os

# Check a specific variable
azure_client_id = os.getenv("AZURE_CLIENT_ID")
print(f"AZURE_CLIENT_ID: {azure_client_id}")

# List all environment variables
# for key, value in os.environ.items():
#     print(f"{key}: {value}")
