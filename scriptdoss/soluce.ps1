$satoru = Get-ADUser -Filter * -SearchBase "CN=Users,DC=cabinet,DC=local" -Server LDAP1.cabinet.local
$gojo = "nomdufichier"


$donnees = "$satoru,$gojo"
$donnees | Out-File "\\C:\Scripts\Alexis\gojo.txt"