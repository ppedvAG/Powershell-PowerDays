[cmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Text
)


do
{

$audioservice = Get-Service -Name Audiosrv

if($audioservice.Status -ne "Running")
{
    $audioservice.Start()
    Start-Sleep -Milliseconds 20
}
 Start-Sleep -Milliseconds 20

}until(( Get-Service -Name Audiosrv).Status -eq "Running")



#Add-Type ermöglicht das laden von DLL / oder .Net Objekten in der Powershell
Add-Type -AssemblyName System.Speech

#erzeugen einer neuen Speech Synthesizer Instanz
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer

#Rate = Geschwindigkeit zwischen -10 und +10. Default Wert is 0
$speak.Rate = -3

#Abfragen der verfügbaren Stimmen
$voices = $speak.GetInstalledVoices().VoiceInfo

$speak.SelectVoice($voices[1].Name)


#Ausführen der Speak Methode
$speak.Speak($Text)

#Am Ende der Verwendung von .NET Objekten oder Assemblies sollten dieses Disposed werden
$speak.Dispose() 
