$prenom = "alexis"
$nom = "joseph"

# Récupérer l'utilisateur correspondant au prénom et nom fournis
$user = Get-ADUser -Filter "GivenName -like '$($prenom)*' -and Surname -like '$($nom)*'" -Properties *

# Vérifier si un utilisateur a été trouvé
if ($user) {
    # Afficher toutes les propriétés de l'utilisateur
    $mail = $user | Select-Object mail
    Write-Host = $mail
} else {
    Write-Host "Utilisateur non trouvé"
}


$OngletBLabelMail =  New-Object System.Windows.Forms.Label
$OngletBLabelMail.Location = New-Object System.Drawing.Point(45, 150)
$OngletBLabelMail.Size = New-Object System.Drawing.Size(71, 13)
$OngletBLabelPrenom.Text='[String]$mail'