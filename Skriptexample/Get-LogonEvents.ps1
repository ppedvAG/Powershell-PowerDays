Param(
$ComputerName,
$EventId,
$Newest
)

Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventId -eq $EventId | Select-Object -First $Newest
