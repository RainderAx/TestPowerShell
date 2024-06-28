# Obtenir tous les utilisateurs AD de la base de recherche spécifiée
$satoru = Get-ADUser -Filter * -SearchBase "CN=Users,DC=cabinet,DC=local" -Server LDAP1.cabinet.local

# Nom du fichier
$gojo = "nomdufichier"

# Créer le fichier si nécessaire
New-Item -Path "C:\Scripts\Alexis\$gojo.txt" -ItemType File -Force


# Convertir les données utilisateur en chaîne de caractères
# Ici, on choisit d'utiliser les propriétés Name et SamAccountName comme exemple
$userData = $satoru | ForEach-Object { "$($_.Name), $($_.SamAccountName)" }

# Préparer les données pour l'écriture dans le fichier
$donnees = "$userData, $gojo"

# Écrire les données dans un fichier
$donnees | Out-File -FilePath "C:\Scripts\Alexis\$gojo.txt"
