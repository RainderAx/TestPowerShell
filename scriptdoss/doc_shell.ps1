
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

#comparaison vérifié si une valeur est nulle
if ($TextTelephone -eq $null -or $TextTelephone -eq '') {
    Write-Output "Gojo > Jogo"
} 

#envoyé mail
$utilisateur =$env:username.Split(".")[1].ToUpper()
$From  = "$env:username@cabinet.local"
$To = 'administrateurs.psnsm@developpement-durable.gouv.fr'
$body = " Bonjour,

Ci-dessous la description du PC $env:computername appartenant à $Nom  :

$Nom $Prenom Bur: $Bureau Tel: $Telephone $Service
       
Ce rapport a été généré par $utilisateur.

Merci de vérifier si ces informations sont correctes" 
$Subject = 'Check_New_Computer'
$SmtpServer = 'mail.cabinet.local'
$Send_mail = Send-MailMessage -From $From -To $To -Subject $Subject  -Body $body -SmtpServer $SmtpServer -port 587 -Encoding unicode


### cherche un utilisateur dans l AD
$poire = "alex"

Get-ADUser -Filter "samAccountName -like '$poire*'"
