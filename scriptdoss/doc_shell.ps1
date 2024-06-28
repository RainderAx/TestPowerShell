
#recuperer la liste des users 
Get-ADUser -Filter * -SearchBase "CN=Users,DC=cabinet,DC=local" -Server LDAP1.cabinet.local

#connaitre le nom de domaine 
$domaine = Get-ADDomainController -Discover

#print 
Write-Output "Nom du Serveur AD : $($domaine.HostName)"

# Créer un fichier
$gojo = "nomdufichier"
New-Item -Path "C:\Scripts\Alexis\$gojo.txt" -ItemType File -Force

# Convertir les données utilisateur en chaîne de caractères
$userData = $satoru | ForEach-Object { "$($_.Name), $($_.SamAccountName)" }

# Cominer des données 
$donnees = "$userData, $gojo"

# Écrire les données dans le fichier
$donnees | Out-File -FilePath "C:\Scripts\Alexis\$gojo.txt"

