$poire = "alexis.joseph"

$buro = 6013


$user = Get-ADUser -Filter "samAccountName -eq '$poire'"


Set-ADUser -Identity $user -Replace @{physicalDeliveryOfficeName = $buro}

(Get-ADUser -Filter "UserPrincipalName -like '$poire*'" -Properties *).Office



