$prenom= "Alexis"
$nom= "JOSEPH"
Get-ADUser -Filter "samAccountName -like '$prenom*'+'$nom*'"


