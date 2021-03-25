[cmdletBinding()] #Laden erweiterter PowerShell Funktionen wie zb Parametereigenschaft, Verbose, Debug
Param( #Keyword zum einführen eines Parameterblocks
[Parameter(Mandatory=$true)]   #Definition das folgende Variable ein Parameter ist mit der Eigenschaft Mandatory = $true. (Pflichparameter)
[string]$ComputerName,    #Parameter mit DatenTyp "vorvalidiert"

[int]$EventId = 4624,     #Parameter mit Default Wert der Verwendet wird wenn keine User "Eingabe" erfolgte

[int]$Newest = 5
)
Write-Verbose -Message "Folgende Werte wurden der Ausführung übergeben: "
Write-Verbose -Message "Computername: $Computername | EventID: $EventId | Newest: $Newest"
Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventId -eq $EventId | Select-Object -First $Newest
