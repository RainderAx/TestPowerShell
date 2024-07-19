$prenom = "Alexis"
$nom = "JOSEPH"
$filter = "samAccountName -like '$($prenom)*$($nom)*'"
Get-ADUser -Filter $filter