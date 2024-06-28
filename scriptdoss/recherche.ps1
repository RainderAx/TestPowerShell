# Charge en mémoire les éléments graphiques nécessaires
[void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')

# Créer le formulaire
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Créer un fichier"
$Form.Size = New-Object System.Drawing.Size(300, 150)
$Form.StartPosition = "CenterScreen"

# Créer le bouton
$Button = New-Object System.Windows.Forms.Button
$Button.Text = "Créer le fichier"
$Button.Size = New-Object System.Drawing.Size(200, 50)
$Button.Location = New-Object System.Drawing.Point(50, 30)

# Ajouter le bouton au formulaire
$Form.Controls.Add($Button)

# Définir l'action du bouton
$Button.Add_Click({
    # Chemin du fichier
    $filePath = "C:\Scripts\Alexis\gojo.txt"
    
    # Données à écrire dans le fichier
    $satoru = Get-ADUser -Filter * -SearchBase "CN=Users,DC=cabinet,DC=local" -Server LDAP1.cabinet.local
    $gojo = "nomdufichier"
    
    # Convertir les données utilisateur en chaîne de caractères
    $userData = $satoru | ForEach-Object { "$($_.Name), $($_.SamAccountName)" }
    
    # Préparer les données pour l'écriture dans le fichier
    $donnees = "$userData, $gojo"
    
    # Créer le fichier si nécessaire
    New-Item -Path $filePath -ItemType File -Force
    
    # Écrire les données dans le fichier
    $donnees | Out-File -FilePath $filePath

    # Message de confirmation
    [System.Windows.Forms.MessageBox]::Show("Fichier créé avec succès : $filePath")
})

# Afficher le formulaire
$Form.ShowDialog()

