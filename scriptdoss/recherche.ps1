# Spécifiez le samAccountName de l'utilisateur
$poire = "alexis.joseph"

# Spécifiez le nouveau numéro de bureau
$buro = "6013"

# Récupérer l'utilisateur pour obtenir l'Identity unique
$user = Get-ADUser -Filter "samAccountName -eq '$poire'"

# Mettre à jour le bureau de l'utilisateur
Set-ADUser -Identity $user -Replace @{physicalDeliveryOfficeName = $buro}

# Vérifier la mise à jour en récupérant à nouveau l'utilisateur
Get-ADUser -Filter "samAccountName -eq '$poire'" -Properties *



