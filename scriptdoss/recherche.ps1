$poire = "alexis.joseph"

$buro = 6013

# Mettre à jour le bureau de l'utilisateur ou Office
Set-ADUser -Identity $poire -Replace @{physicalDeliveryOfficeName = $buro}

Get-ADUser -Filter "UserPrincipalName -like '$poire*'" -Properties *


