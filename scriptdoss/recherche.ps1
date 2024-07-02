$poire = "alexis.joseph"

$buro = 6013

Set-ADUser -Identity $poire -Office $Utilisateur.Fonction = buro

Get-ADUser -Filter "UserPrincipalName -like '$poire*'" -Properties *