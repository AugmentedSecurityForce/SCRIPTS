# Purpose
PowerShell script that can send an email with the content of an RSS feed. The mail contains only the content published since the last two days.

## This script uses
* the Invoke-WebRequest cmdlet to retrieve the RSS feed from the specified URL. 
* the Select-Xml cmdlet to extract the item elements from the feed. 
* These elements are looped through and the title and description are extracted and added to the email body. 
* The pubDate element of each item to determine when it was published. It then calculates the number of days between the publication date and the current date, and only includes the item in the email if it was published within the last two days.
* The $smtpUsername and $smtpPassword variables, which contain the authentication credentials for the SMTP server.
* The Send-MailMessage cmdlet is used to send the email with the content of the RSS feed to the specified recipient.

