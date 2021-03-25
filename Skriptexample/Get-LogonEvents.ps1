<#
.Synopsis
    Kurzbeschreibung was das Skript macht. z.b.  Abfrage von SecurityEvents
.Description
    Lange Beschreibung was das Skript macht z.B. Abfrage von Anmeldebezogenen Events. Mit diesem Skript können AnmeldeEvents, Abmeldevents und fehlgeschlagene Anmeldungen ausgewertet werden.
.PARAMETER ComputerName
    Mit diesem Parameter kann der Computername angegeben werden von dem diese Events abgefragt werden
.PARAMETER EVentID
    Mit diesem Parameter wird die EVentId definiert die zum Abfragen verwendet wird.
    
    4624 Anmeldung / Default
    4634 Abmeldung
    4625 fehlgeschlagene Anmeldung
.PARAMETER Newest
    Definiert die Anzahl der anzuzeigenden Events. Defaultwert 5
.EXAMPLE
    Get-LogonEvents.ps1 -ComputerName Member1

    Diese Verwendung frägt von einem Computer mit dem Namem "Member1" die aktuellesten fünf Events mit der EventID 4624 ab

    Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
    2351 Mrz 25 09:41  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet...
    2348 Mrz 25 09:41  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet...
    2345 Mrz 25 09:41  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet...
    2342 Mrz 25 09:41  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet...
    2339 Mrz 25 09:41  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet...    
#>
[cmdletBinding()] #Laden erweiterter PowerShell Funktionen wie zb Parametereigenschaft, Verbose, Debug
Param( #Keyword zum einführen eines Parameterblocks
[Parameter(Mandatory=$true)]   #Definition das folgende Variable ein Parameter ist mit der Eigenschaft Mandatory = $true. (Pflichparameter)
[string]$ComputerName,    #Parameter mit DatenTyp "vorvalidiert"

[int]$EventId = 4624,     #Parameter mit Default Wert der Verwendet wird wenn keine User "Eingabe" erfolgte

[int]$Newest = 5
)

#Write-Verbose erzeigt eine zusätzliche "Ausführliche" Ausgabe die nur ausgebenen wird wenn das Skript mit -Verbose gestartet wird
Write-Verbose -Message "Folgende Werte wurden der Ausführung übergeben: "
Write-Verbose -Message "Computername: $Computername | EventID: $EventId | Newest: $Newest"

Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventId -eq $EventId | Select-Object -First $Newest
