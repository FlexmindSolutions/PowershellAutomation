## This script will be used to generate CSV report file related to MS Teams of an organisation.
## Pre-requisite: Connect to Microsoft Teams Powershell & Exchange Online Powershell.
## Link for MS Team: https://docs.microsoft.com/en-us/powershell/teams/?view=teams-ps
## Link for Exchange online: https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell?view=exchange-ps
## Version: 1.0 
## Date: 16-04-2020
## Author: Rakesh Pandey

$team = Get-Team
$csvreport = foreach($grpid in $team.GroupId)
{
$TeamName = Get-Team -GroupId $grpid
$TeamCreationDate = Get-UnifiedGroup -identity $grpid | Select -expandproperty WhenCreatedUTC
Get-TeamUser -GroupId $grpid |Select-Object @{Name='Team';Expression ={$TeamName.DisplayName}},User,Name,Role,@{Name='Team Creation Date';Expression ={$TeamCreationDate}}
}
$csvreport | Export-Csv -Path '<Location to CSV File>\TeamReport.Csv'
