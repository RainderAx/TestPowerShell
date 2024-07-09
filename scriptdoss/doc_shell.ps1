
#recuperer la liste des bases du serveur
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


### cherche un utilisateur dans l AD recupere TOUTE ses infos
$poire = "alex"

Get-ADUser -Filter "samAccountName -like '$poire*'"

# Créer le menu déroulant (ComboBox)
$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = New-Object System.Drawing.Point(170, 20)
$comboBox.Size = New-Object System.Drawing.Size(100, 20)
$comboBox.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList

# Ajouter des options au menu déroulant
$options = @("BAT4", "BAT5", "BAT6", "ROQUELAURE", "LEPLAY", "LESDIGUIERE")
$comboBox.Items.AddRange($options)

##Switch Case
$selectedOption = $comboBox.SelectedItem

    switch ($selectedOption) {
        "Option 1" { [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : Option 1") }
        "Option 2" { [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : Option 2") }
        "Option 3" { [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : Option 3") }
        "Option 4" { [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : Option 4") }
        default { [System.Windows.Forms.MessageBox]::Show("Option non reconnue") }
    }


$button.Size = New-Object System.Drawing.Size(48, 20)
##### (X , Y)



###lancer des exec
$NomLogiciel = "calc"

switch -Wildcard ($NomLogiciel)
{
    "N?TEPAD" { Start-Process notepad.exe }
    "note*" { Start-Process notepad.exe }
    "calc" { Start-Process calc.exe }
    "regedit" { Start-Process regedit.exe }
    Default { "Désolé, je n'ai pas trouvé ce logiciel" }
}

###crere un tableau
$valeur = 0..10