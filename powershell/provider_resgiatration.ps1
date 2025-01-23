$providerNamespaces = @(
    "Microsoft.SqlVirtualMachine"
)
foreach ($namespace in $providerNamespaces) {
    try {
        Register-AzResourceProvider -ProviderNamespace $namespace -ErrorAction Stop -Verbose
        Write-Host "Successfully registered provider: $namespace"
    } catch {
        Write-Host "Failed to register provider: $namespace"
        Write-Host "Error: $_"
    }
}
Register-AzProviderFeature -FeatureName BulkRegistration -ProviderNamespace Microsoft.SqlVirtualMachine -ErrorAction Stop -Verbose