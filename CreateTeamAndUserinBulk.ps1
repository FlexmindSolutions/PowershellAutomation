## This script will be used to create a Team and add bulk user from csv file to the newly created team.
## Before running this script use Connect-MicrosoftTeams to connect your MS Teams.
## Version: 1.0 
## Date: 24-2-2020
## Author: Rakesh Pandey
$date = Get-Date -Format M
$logfile = "<Path to log file>\$date-useraddlog.txt"
$startdt = [System.DateTime]::Now
Write-Output "Start Time: $startdt `r`n" | Out-File $logfile -Append
Write-Output "************************" | Out-File $logfile -Append
$inputcsvfile = Import-Csv (Read-Host "Enter CSV Location")
$teamName  = Read-Host "Please enter Team Name"
$teamDescription = Read-Host "Please enter Team Description"
#Create Team
New-Team -DisplayName $teamName -Description $teamDescription
$grp = Get-Team -DisplayName $teamName
$grpid = $grp.GroupId
Write-Output "Created Team: $teamName groupid: " $grpid | Out-File $logfile -Append
## Add user from csv file
foreach($line in $inputcsvfile)
{
  Add-TeamUser -GroupId $grpid -User $line.EmailAddres -Role $line.Role -ErrorAction SilentlyContinue
  Write-Output "Added user: "$line.EmailAddres" Role: "$line.Role | Out-File $logfile -Append
}
Write-Output "************************" | Out-File $logfile -Append
$enddt = [System.DateTime]::Now
Write-Output "End Time: $enddt `r`n" | Out-File $logfile -Append