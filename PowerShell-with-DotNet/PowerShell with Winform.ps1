[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$windows = New-Object System.Windows.Forms.Form

$windows.StartPosition = "CenterScreen"

$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Location = New-Object System.Drawing.Size(300,100)
$textbox.Size = New-Object System.Drawing.Size(200,20)

$windows.Controls.Add($textbox)


[void] $windows.ShowDialog()