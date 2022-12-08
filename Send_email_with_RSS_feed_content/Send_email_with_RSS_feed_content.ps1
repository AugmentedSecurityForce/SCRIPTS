# Set the variables for the RSS feed URL, the email recipient, the sender address, and the SMTP credentials
$rssFeed = 'https://rss.com/feed'
$emailRecipient = 'user@example.com'
$emailSender = 'rssbot@example.com'
$smtpUsername = 'smtp-username'
$smtpPassword = 'smtp-password'

# Set the SMTP server and port
$smtpServer = 'smtp.example.com'
$smtpPort = 587

# Use the Invoke-WebRequest cmdlet to retrieve the RSS feed
$rss = Invoke-WebRequest -Uri $rssFeed

# Use the Select-Xml cmdlet to extract the item elements from the RSS feed
$items = Select-Xml -Xml ([xml]$rss.Content) -XPath "//item"

# Create a string variable to hold the email body
$emailBody = ''

# Loop through each item element in the RSS feed
foreach ($item in $items.Node) {
  # Extract the publication date of the item
  $pubDate = $item.SelectSingleNode('pubDate').InnerText

  # Convert the publication date to a DateTime object
  $pubDate = [datetime]$pubDate

  # Calculate the number of days between the publication date and the current date
  $daysSincePubDate = (Get-Date) - $pubDate

  # If the item was published in the last two days, add it to the email body
  if ($daysSincePubDate.Days -le 2) {
    $title = $item.SelectSingleNode('title').InnerText
    $description = $item.SelectSingleNode('description').InnerText

    $emailBody += "$title`n$description`n`n"
  }
}

# Use the Send-MailMessage cmdlet to send the email
Send-MailMessage -From $emailSender -To $emailRecipient -Body $emailBody -Subject 'RSS Feed' -SmtpServer $smtpServer -Port $smtpPort -Credential (New-Object System.Management.Automation.PSCredential -ArgumentList $smtpUsername, (ConvertTo-SecureString -String $smtpPassword -AsPlainText -Force))
