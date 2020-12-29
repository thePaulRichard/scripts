#Copy all code below on PowerShell
#If you get the error: Import-PSSession : Files cannot be loaded because running scripts is disabled on this system. Provide a valid
certificate with which to sign the files.
#Execute the command bellow (as Administrator):
Set-ExecutionPolicy RemoteSigned
#____________________________________________________________________________________

#Script Start (No Administrator needed)

#Path and name of the report
$export = "$env:USERPROFILE\Desktop\exchange.csv"

#User and pass from the Office 365 Administrator
$UserCredential = Get-Credential

#Azure Active Directory Module.
#If you get an error: https://technet.microsoft.com/en-us/library/dn975125.aspx
Import-Module MSOnline

#Create Exchange Online connection
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/
-Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session
Connect-MsolService -Credential $UserCredential

#END OF REMOTE CONNECTION
#END OF REMOTE CONNECTION
#END OF REMOTE CONNECTION

#____________________________________________________________________________________
#Licenses Report
$Report=@()
$Mailboxes = Get-Mailbox -identity "paulo.paim@quirius.com.br" #One account (Comment the line below)
#$Mailboxes = Get-Mailbox -ResultSize Unlimited | where {$_.RecipientTypeDetails -ne "DiscoveryMailbox"} #All accounts (Comment the
line above)
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
