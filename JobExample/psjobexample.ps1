$job1 = Start-Job -ScriptBlock {"Do Something"}
$job2 = Start-Job -ScriptBlock {"Do Something different"}
 
do
{#Schleife zum warten bis beide Jobs fertig sind
Start-Sleep -Milliseconds 50
}until($job1.Status -eq "Completed" -and $job2.Status -eq "Completed")