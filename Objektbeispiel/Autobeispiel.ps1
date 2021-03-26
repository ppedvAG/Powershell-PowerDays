#Die Klassen wurden in der PowerShell Version 5 eingeführt und können zum erzeugen eigener Klassen verwendet werden. 
#Welche man wiederrum für Custom Ausgabeobjekte verwenden könnte anstatt einer Hashtable / Assoziatives Array
class Auto
{   #Properties / Eigenschaften die ein Auto haben kann
    [string]$vin
    static [int]$numberofwheels = 4
    [datetime]$year
    [string]$Model
    [Farben]$Farbe

    #Eigene Methode / Function welche im Objekt verwendet werden kann
    [void]Drive([int]$Meter)
    {
        #In Methoden / Functionen innerhalb von Skripten müssen Variablen ähnlich wie in c# sauber deklariert und initialisiert werden mit einem DatenTypen.
        [string]$Fahrbahn = ""
        for([int]$i = 0; $i -le $Meter; $i++)
        {
            $Fahrbahn += " - "
            Write-Host -Object ($Fahrbahn + "🚗" + "-")
            Start-Sleep -Milliseconds 30
        } 
    }
}

#Zur Vorgabe von Festgelegten Werten
Enum Farben
{
    Grau
    Silber
    Schwarz
    Blau
    Grün
}

#Erzeugen einer neuen Instanz der Klasse Auto
$bmw = New-Object Auto
$bmw.Farbe = [Farben]::Silber
$bmw.year = [datetime]::ParseExact("14.04.2017","dd.MM.yyyy",$null)
$bmw.Model = "BMW F31"
$bmw.vin = "Fahrgestellnummer"

$bmw | Get-Member