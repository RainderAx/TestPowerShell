$prenom = "Alexis"
$nom = "JOSEPH"
 
 $test=(Get-ADUser -Filter "samAccountName -like '$($prenom)*$($nom)*'").UserPrincipalName

 Write-Host $test