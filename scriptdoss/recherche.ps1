# Obtenir tous les utilisateurs AD de la base de recherche spécifiée
$satoru = Get-ADUser -Filter * -SearchBase "CN=Users,DC=cabinet,DC=local" -Server LDAP1.cabinet.local

$gojo = "nomdufichier"

# Créer le fichier si nécessaire
New-Item -Path "C:\Scripts\Alexis\$gojo.txt" -ItemType File -Force

$userData = $satoru | ForEach-Object { "$($_.Name), $($_.SamAccountName)" }

# Préparer les données pour l'écriture dans le fichier
$donnees = "$userData, $gojo"

# Écrire les données dans un fichier
$donnees | Out-File -FilePath "C:\Scripts\Alexis\$gojo.txt"
