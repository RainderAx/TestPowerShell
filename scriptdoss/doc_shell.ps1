Get-ADUser -Filter * -SearchBase "CN=Users,DC=cabinet,DC=local" -Server LDAP1.cabinet.local

#connaitre le nom de domaine 
$domaine = Get-ADDomainController -Discover

Write-Output "Nom du Serveur AD : $($domaine.HostName)"