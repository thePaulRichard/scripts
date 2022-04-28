# Copy all code below on PowerShell
# If you get the error: Import-PSSession : Files cannot be loaded because running scripts is disabled on this system. Provide a valid certificate with which to sign the files.
# Execute the following command as Administrator:
Set-ExecutionPolicy RemoteSigned

# Path to export the report
$export = "$env:USERPROFILE\Desktop\exchange.csv"

# User and password from the Office 365 Administrator
$UserCredential = Get-Credential

# Azure Active Directory Module.
# If you get an error: https://technet.microsoft.com/en-us/library/dn975125.aspx
Import-Module MSOnline

#Create Exchange Online connection
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session
Connect-MsolService -Credential $UserCredential

# Licenses Report
$Report=@()

# For one user only, use the code bellow
$Mailboxes = Get-Mailbox -identity "paulopaim@outlook.com"

# For all accounts comment the code above and uncomment bellow
#$Mailboxes = Get-Mailbox -ResultSize Unlimited | where {$_.RecipientTypeDetails -ne "DiscoveryMailbox"} #All accounts (Comment the line above)

foreach ($mailbox in $Mailboxes){
$UserStat = Get-User -identity $mailbox.UserPrincipalName
$MailboxStat = Get-MailboxStatistics $mailbox.UserPrincipalName
$LastLogonTime = $MailboxStat.LastLogonTime
$MSOLUSER = Get-MsolUser -UserPrincipalName $mailbox.UserPrincipalName
    foreach($license in $MSOLUSER.Licenses){
        $Report += New-Object PsObject -Property @{
            "User"="$($mailbox.DisplayName)";
            "Mail"="$($mailbox.UserPrincipalName)";
            "Company"="$($UserStat.Company)";
            "Department"="$($UserStat.Department)";
            "Manager"="$($UserStat.Manager)";
            "Title"="$($UserStat.Title)";
            "AccountSKUID"="$($license.AccountSKUid)"
        }
    }
}

$Report | Export-CSV $export -NoTypeInformation
