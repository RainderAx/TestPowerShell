
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

# Combiner des données 
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
$langages = @("PowerShell","Python","PHP","JavaScript","C-Sharp")

###return
PS C:\temp> function ContrivedFolderMakerFunction {
    >>    $folderName = [DateTime]::Now.ToFileTime()
    >>    $folderPath = Join-Path -Path . -ChildPath $folderName
    >>    New-Item -Path $folderPath -ItemType Directory
    >>    return $true
    >> }
    PS C:\temp> $result = ContrivedFolderMakerFunction
    PS C:\temp> $result


    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::EnableVisualStyles()
    
    $Form = New-Object System.Windows.Forms.Form
    $Form.ClientSize = ‘500,500’ # Taille de la fenêtre
    $Form.Text = "Mon UI en PS ep. II" # Titre de la fenêtre
    $Form.FormBorderStyle = ‘Fixed3D’
    $Form.MaximizeBox = $false 
    
    $Menu = New-Object System.Windows.Forms.MenuStrip
    $Menu.Location = New-Object System.Drawing.Point(0, 0) 
    $Menu.ShowItemToolTips = $True 
    
    
    $MenuFile = New-Object System.Windows.Forms.ToolStripMenuItem
    $MenuFile.Text = " &Fichier " 
    
    $MenuAbout = New-Object System.Windows.Forms.ToolStripMenuItem
    $MenuAbout.Text = " &A propos " 
    
    $MenuFileQuit = New-Object System.Windows.Forms.ToolStripMenuItem
    $MenuFileQuit.Text = " &Quitter " 
    $MenuFileQuit.ToolTipText = " Infobulle d’aide " 
    
    
    $MenuFileQuit.Add_Click({
        $Form.Close() 
    })
    
    
    $MenuFile.DropDownItems.Add($MenuFileQuit)
    
    $Menu.Items.AddRange(@($MenuFile, $MenuAbout))
    
    $Form.Controls.Add($Menu)
    
    $Form.Add_Shown({ $Form.Activate() }) 
    [void]$Form.ShowDialog() 


####if else
if (-not $Global:VerifPrenom -or -not $Global:VerifNom -or -not $Global:VerifTelephone) {
    [System.Windows.Forms.MessageBox]::Show("Please ensure all fields are correctly filled out.")
    return
} else {
    [System.Windows.Forms.MessageBox]::Show("cestfé")
}

####properties
mail/Office/AccountExpirationDate/telephoneNumber/Name