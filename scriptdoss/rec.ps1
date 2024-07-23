$prenom = "alexis"
$nom = "joseph"

# Récupérer l'utilisateur correspondant au prénom et nom fournis
$user = Get-ADUser -Filter "GivenName -like '$($prenom)*' -and Surname -like '$($nom)*'" -Properties *

# Vérifier si un utilisateur a été trouvé
if ($user) {
    # Afficher toutes les propriétés de l'utilisateur
    $Na = $user | Select-Object Name
    $Mail = $user | Select-Object mail 
    $AccountExpirationDate = $user | Select-Object AccountExpirationDate
    $telephoneNumber = $user | Select-Object telephoneNumber
    $Title = $user | Select-Object Title
    $log=$user | Select-Object Title SamAccountName
    
} else {
    Write-Host "Utilisateur non trouvé"
}

$OngletBLabelPrenom = New-Object System.Windows.Forms.Label
$OngletBLabelPrenom.Location = New-Object System.Drawing.Point(30, 140)
$OngletBLabelPrenom.Text= $Na
$OngletBLabelPrenom.Size = New-Object System.Drawing.Size(80, 20)


$OngletBLabelTelephone = New-Object System.Windows.Forms.Label
$OngletBlabelTelephone.Location = New-Object System.Drawing.Point(30, 120)
$OngletBLabelTelephone.Size = New-Object System.Drawing.Size(71, 13)
$OngletBLabelTelephone.Text = $telephoneNumber

$OngletBlalbelLog = New-Object System.Windows.Forms.Label
$OngletBlalbelLog.Location = New-Object System.Drawing.Point(70, 150)
$OngletBlalbelLog.Size = New-Object System.Drawing.Size(71, 13)
$OngletBlalbelLog.Text=$log

$OngletBLabelMail =  New-Object System.Windows.Forms.Label
$OngletBLabelMail.Location = New-Object System.Drawing.Point(45, 150)
$OngletBLabelMail.Size = New-Object System.Drawing.Size(71, 13)
$OngletBLabelMail.text = $Mail

$OngletBLabelAccExp =  New-Object System.Windows.Forms.Label
$OngletBLabelAccExp.Location = New-Object System.Drawing.Point(45, 150)
$OngletBLabelAccExp.Size = New-Object System.Drawing.Size(71, 13)
$OngletBLabelAccExp.text = $AccountExpirationDate

$TabPage2.Controls.Add($OngletBLabelPrenom)
$TabPage2.Controls.Add($OngletBLabelTelephone)
$TabPage2.Controls.Add($OngletBlalbelLog)
$TabPage2.Controls.Add($OngletBLabelMail)
$TabPage2.Controls.Add($OngletBLabelAccExp)