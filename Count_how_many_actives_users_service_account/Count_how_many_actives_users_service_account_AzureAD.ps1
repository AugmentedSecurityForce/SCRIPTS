# Import the necessary modules
Import-Module -Name 'AzureAD'

# Authenticate with Azure AD
Connect-AzureAD

# Get all user accounts from Azure AD
$accounts = Get-AzureADUser

# Filter the accounts to only include those on Azure AD (not hybrid)
$azureAccounts = $accounts | Where-Object { $_.AccountEnabled -eq $true }

# Output the results
$azureAccounts | Format-Table -Property 'DisplayName', 'UserPrincipalName'