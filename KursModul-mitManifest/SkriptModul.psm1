#Funktion zum erstellen der TestFiles 
function New-TestFiles
{
    [cmdletBinding()]
    param(
        [ValidateScript({Test-Path -Path $PSItem})]
        [Parameter(Mandatory=$true)]
        [string]$Path,

        [int]$FileCount = 9,

        [string]$Prefix = ""
    )

    for($i = 1; $i -le $FileCount; $i++)
    {
        $FileName = $Prefix + "Datei" + ("{0:D3}" -f $i) + ".txt"
        New-Item -Path $Path -Name $FileName -ItemType File
    }
}

function New-TestFilesDir
{
[cmdletBinding(PositionalBinding=$false)]
Param(
    [ValidateScript({Test-Path -Path $PSItem})]
    [Parameter(Mandatory=$true,Position=0)]
    [string]$Destinationpath,

    [ValidateLength(3,10)]
    [string]$Ordnername = "TestFiles",

    [ValidateRange(1,100)]
    [int]$FileCount = 9,

    [ValidateRange(1,100)]
    [int]$DirCount = 3,

    [switch]$Force

)


if($Destinationpath.EndsWith("\"))
{
    $TestFilespath = $Destinationpath + $Ordnername
}
else
{
    $TestFilespath = "$Destinationpath\$Ordnername"
}

if((Test-Path -Path $TestFilesPath))
{
    if($Force)
    {
        Remove-Item -Path $TestFilesPath -Recurse -Force
    }
    else
    {
        Write-Host -ForegroundColor Red -Object "Ordner bereits vorhanden"
        exit
    }
}

New-Item -Path $Destinationpath -Name $Ordnername -ItemType Directory

New-TestFiles -Path $TestFilespath -FileCount $FileCount

for($i = 1; $i -le $DirCount;$i++)
{
   $DirPath = $TestFilesPath +  "\Ordner" + ("{0:D3}" -f $i)
   New-Item -Path $DirPath -ItemType Directory

   New-TestFiles -Path $DirPath -Prefix "Ordner$("{0:D3}" -f $i)"
}
}

function Test-Debug
{
    [cmdletBinding()]
    param(
        [string]$Eingabe = "Input"
    )
    Write-Debug -Message "Vor Erster Ausgabe"
    Write-Host -Object "Erste Ausgabe: $Eingabe" -ForegroundColor White

    Write-Debug -Message "Vor zweiter Ausgabe"
    Write-Host -Object "Zweite Ausgabe: $Eingabe" -ForegroundColor Cyan
}

function Test-ParameterSet
{
[cmdletBinding(PositionalBinding=$false,DefaulParameterSetName="Set1")]
param(
    [Parameter(Mandatory = $true,ParameterSetName="Set1")]
    [string]$Parameter1,

    [Parameter(Mandatory = $true, ParameterSetName="Set2")]
    [string]$Parameter2,

    [Parameter(Mandatory = $true,ParameterSetName="Set1")]
    [Parameter(Mandatory = $false,ParameterSetName="Set2")]
    [string]$Parameter3
)
}

function Test-PipelineInput
{
[cmdletBinding()]
param(
    [Parameter(Mandatory=$true,ValueFromPipeLine=$true,ValueFromPipelineByPropertyName=$true)]
    [string[]]$Name,
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [string[]]$PM
)
    Begin
    {
        Write-Host -ForegroundColor Green -Object "Ich laufe einmal am Anfang"
    }
    Process
    {
        Write-Debug -Message "VorAusgabe"
        Write-Host -ForegroundColor Magenta -Object $Name
        Write-Host -ForegroundColor Cyan -Object $PM
    }
    End
    {
         Write-Host -ForegroundColor Green -Object "Ich laufe einmal am Ende"
    }
}