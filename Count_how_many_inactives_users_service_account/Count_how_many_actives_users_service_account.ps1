# Import the necessary module
Import-Module -Name 'ActiveDirectory'

# Set the time frame for active accounts
$timeFrame = (Get-Date).AddDays(-90)

# Get all user accounts and services in the domain
$accounts = Get-ADUser -Filter *
$services = Get-ADServiceAccount -Filter *

# Count the number of user accounts and services that were active within the time frame
$activeUserAccounts = ($accounts | Where-Object { $_.LastLogonTimeStamp -gt $timeFrame }).Count
$activeServices = ($services | Where-Object { $_.LastLogonTimeStamp -gt $timeFrame }).Count

# Output the results
Write-Output "Active user accounts: $activeUserAccounts"
Write-Output "Active services: $activeServices"