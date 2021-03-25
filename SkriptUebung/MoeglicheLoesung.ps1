[cmdletBinding()]
Param(
    [ValidateScript({Test-Path -Path $PSItem})]
    [string]$Destinationpath,

    [ValidateLength(3,10)]
    [string]$Ordnername = "TestFiles",

    [ValidateRange(1,100)]
    [int]$FileCount = 9,

    [ValidateRange(1,100)]
    [int]$DirCount = 3,

    [switch]$Force

)
 
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


