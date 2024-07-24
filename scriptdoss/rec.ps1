Add-Type -AssemblyName System.Windows.Forms

$prenom = "alexis"
$nom = "joseph"

# Récupérer l'utilisateur correspondant au prénom et nom fournis
$user = Get-ADUser -Filter "GivenName -like '$($prenom)*' -and Surname -like '$($nom)*'" -Properties *

# Créer un formulaire
$form = New-Object System.Windows.Forms.Form
$form.Text = "Informations Utilisateur AD"
$form.Size = New-Object System.Drawing.Size(400, 300)

# Créer un TabControl
$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Dock = [System.Windows.Forms.DockStyle]::Fill

# Créer le TabPage pour les informations utilisateur
$TabPage2 = New-Object System.Windows.Forms.TabPage
$TabPage2.Text = "Détails Utilisateur"

if ($user) {
    # Récupérer les propriétés de l'utilisateur
    $Na = $user.Name
    $Mail = $user.mail 
    $AccountExpirationDate = $user.AccountExpirationDate
    $telephoneNumber = $user.telephoneNumber
    $Title = $user.Title
    $log = $user.SamAccountName

    # Afficher les propriétés dans des labels
    $OngletBLabelPrenom = New-Object System.Windows.Forms.Label
    $OngletBLabelPrenom.Location = New-Object System.Drawing.Point(30, 20)
    $OngletBLabelPrenom.Size = New-Object System.Drawing.Size(300, 20)
    $OngletBLabelPrenom.Text = "Nom: $Na"

    $OngletBLabelMail = New-Object System.Windows.Forms.Label
    $OngletBLabelMail.Location = New-Object System.Drawing.Point(30, 50)
    $OngletBLabelMail.Size = New-Object System.Drawing.Size(300, 20)
    $OngletBLabelMail.Text = "Email: $Mail"

    $OngletBLabelAccExp = New-Object System.Windows.Forms.Label
    $OngletBLabelAccExp.Location = New-Object System.Drawing.Point(30, 80)
    $OngletBLabelAccExp.Size = New-Object System.Drawing.Size(300, 20)
    $OngletBLabelAccExp.Text = "Expiration du compte: $AccountExpirationDate"

    $OngletBLabelTelephone = New-Object System.Windows.Forms.Label
    $OngletBLabelTelephone.Location = New-Object System.Drawing.Point(30, 110)
    $OngletBLabelTelephone.Size = New-Object System.Drawing.Size(300, 20)
    $OngletBLabelTelephone.Text = "Téléphone: $telephoneNumber"

    $OngletBlalbelLog = New-Object System.Windows.Forms.Label
    $OngletBlalbelLog.Location = New-Object System.Drawing.Point(30, 140)
    $OngletBlalbelLog.Size = New-Object System.Drawing.Size(300, 20)
    $OngletBlalbelLog.Text = "Login: $log"

    # Ajouter les labels au TabPage
    $TabPage2.Controls.Add($OngletBLabelPrenom)
    $TabPage2.Controls.Add($OngletBLabelMail)
    $TabPage2.Controls.Add($OngletBLabelAccExp)
    $TabPage2.Controls.Add($OngletBLabelTelephone)
    $TabPage2.Controls.Add($OngletBlalbelLog)
} else {
    $noUserLabel = New-Object System.Windows.Forms.Label
    $noUserLabel.Location = New-Object System.Drawing.Point(30, 20)
    $noUserLabel.Size = New-Object System.Drawing.Size(300, 20)
    $noUserLabel.Text = "Utilisateur non trouvé"
    $TabPage2.Controls.Add($noUserLabel)
}

# Ajouter le TabPage au TabControl
$tabControl.TabPages.Add($TabPage2)

# Ajouter le TabControl au formulaire
$form.Controls.Add($tabControl)

# Afficher le formulaire
$form.ShowDialog()
