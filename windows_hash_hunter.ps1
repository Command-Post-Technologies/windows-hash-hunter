clear
<#>
Created by Command Post Technologies
</#>
#user input
$drive = Read-Host -Prompt 'what drive would you like to scan? eg "C:\"'
$exportlocation = Read-Host -Prompt 'where would you like the results saved? eg"C:\Temp\results.csv"'
$shaQuestion = Read-Host -Prompt 'are you looking for a specific sha? eg"yes" or "no"'

#this sections spiders the $drive and saves the sha and file location to $exportlocation
Write-Host Saving all generated hashes to $exportlocation this can take a long time...
$filestocheck = Get-ChildItem -Path $drive -Recurse -File -ErrorAction SilentlyContinue | Get-FileHash -Algorithm SHA1 -ErrorAction SilentlyContinue 
$filestocheck | Export-Csv -Path $exportlocation -Append

#this section checks each hash agains the one provided above
if ($shaQuestion -eq "yes"){
$sha1_file_to_locate = Read-Host -Prompt 'Please enter the sha1 with no spaces'
$table = Import-Csv -Path $exportlocation
Write-Host hashes created checking against $sha1_file_to_locate
foreach($line in $table.Hash){if($line -match $regex){
if ($sha1_file_to_locate -eq $line){write-host match was found please check $exportlocation ...checking remaining hashes}
}}
Write-Host check is complete
}
elseif ($shaQuestion -ne "yes"){Write-Host $drive has been hashed please go to $exportlocation for more information}