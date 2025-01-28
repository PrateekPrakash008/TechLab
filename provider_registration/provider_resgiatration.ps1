param (
        [Parameter(Mandatory = $True)] [System.Guid] $CLIENT_ID,
        [Parameter(Mandatory = $True)] [String] $CLIENT_SECRET,
        [Parameter(Mandatory = $True)] [System.Guid] $TENANT_ID,
        [Parameter(Mandatory = $True)] [String] $SUBSCRIPTION_ID
    )

$SecureStringPwd = $CLIENT_SECRET | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $CLIENT_ID, $SecureStringPwd

Connect-AzAccount -ServicePrincipal -TenantId $TENANT_ID -Credential $Credential -WarningAction SilentlyContinue -SubscriptionId $SUBSCRIPTION_ID | Out-Null

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