# Charger les éléments graphiques nécessaires
[void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
$Form10 = New-Object System.Windows.Forms.Form

# Déclaration des contrôles
$TextBoxPrenom = New-Object System.Windows.Forms.TextBox
$TextBoxNom = New-Object System.Windows.Forms.TextBox
$TextTelephone = New-Object System.Windows.Forms.TextBox
$button_generer = New-Object System.Windows.Forms.Button
$button_quitter = New-Object System.Windows.Forms.Button
$LabelPrenom = New-Object System.Windows.Forms.Label
$LabelPrenomError = New-Object System.Windows.Forms.Label
$LabelNom = New-Object System.Windows.Forms.Label
$LabelNomError = New-Object System.Windows.Forms.Label
$LabelTelephone = New-Object System.Windows.Forms.Label
$LabelTelephoneError = New-Object System.Windows.Forms.Label
$LabelPoste = New-Object System.Windows.Forms.Label
$Labelservice = New-Object System.Windows.Forms.Label
$labelMessage = New-Object System.Windows.Forms.Label
$ComboBoxService = New-Object System.Windows.Forms.ComboBox
$ComboBoxPoste = New-Object System.Windows.Forms.ComboBox
$TextBoxLogin = New-Object System.Windows.Forms.TextBox
$LabelLogin = New-Object System.Windows.Forms.Label
$tabcontrol_Cabinet = New-Object System.Windows.Forms.TabControl
$tabpage_newuser = New-Object System.Windows.Forms.TabPage
$tabpage_newuser.Text = "Nouvel Utilisateur"
$tabcontrol_Cabinet.TabPages.Add($tabpage_newuser)

# Initialisation du formulaire
$Form10.Text = "Formulaire d'inscription"
$Form10.Size = New-Object System.Drawing.Size(600, 500)
$Form10.Controls.Add($tabcontrol_Cabinet)

# Position des contrôles sur le tabpage_newuser
$tabpage_newuser.Controls.Add($LabelNom)
$tabpage_newuser.Controls.Add($LabelNomError)
$tabpage_newuser.Controls.Add($LabelPrenom)
$tabpage_newuser.Controls.Add($LabelPrenomError)
$tabpage_newuser.Controls.Add($LabelTelephone)
$tabpage_newuser.Controls.Add($LabelTelephoneError)
$tabpage_newuser.Controls.Add($LabelPoste)
$tabpage_newuser.Controls.Add($Labelservice)
$tabpage_newuser.Controls.Add($labelMessage)
$tabpage_newuser.Controls.Add($button_quitter)
$tabpage_newuser.Controls.Add($button_generer)
$tabpage_newuser.Controls.Add($TextTelephone)
$tabpage_newuser.Controls.Add($TextBoxPrenom)
$tabpage_newuser.Controls.Add($TextBoxNom)
$tabpage_newuser.Controls.Add($ComboBoxPoste)
$tabpage_newuser.Controls.Add($ComboBoxService)

# Déclaration et position des étiquettes et boîtes de texte
$LabelPrenom.AutoSize = $true
$LabelPrenom.Location = New-Object System.Drawing.Point(15, 105)
$LabelPrenom.Text = 'Prenom'
$LabelPrenomError.AutoSize = $true
$LabelPrenomError.Location = New-Object System.Drawing.Point(375, 105)
$LabelPrenomError.Text = ''
$LabelNom.AutoSize = $true
$LabelNom.Location = New-Object System.Drawing.Point(15, 155)
$LabelNom.Text = 'Nom'
$LabelNomError.AutoSize = $true
$LabelNomError.Location = New-Object System.Drawing.Point(375, 155)
$LabelNomError.Text = ''
$LabelTelephone.AutoSize = $true
$LabelTelephone.Location = New-Object System.Drawing.Point(15, 255)
$LabelTelephone.Text = 'Telephone (optionel)'
$LabelPoste.AutoSize = $true
$LabelPoste.Location = New-Object System.Drawing.Point(15, 305)
$LabelPoste.Text = 'Poste'
$LabelTelephoneError.AutoSize = $true
$LabelTelephoneError.Location = New-Object System.Drawing.Point(260, 255)
$LabelTelephoneError.Text = ''
$button_quitter.Location = New-Object System.Drawing.Point(450, 400)
$button_quitter.Text = 'Quitter'
$button_quitter.Add_Click({$Form10.close()})
$button_generer.Location = New-Object System.Drawing.Point(53, 400)
$button_generer.Text = 'Generer'

# Configuration du contrôle TabControl
$TabControl = New-Object System.Windows.Forms.TabControl
$TabControl.Size = New-Object System.Drawing.Size(580, 450)
$TabControl.Location = New-Object System.Drawing.Point(10, 10)
$Form10.Controls.Add($TabControl)
$TabControl.TabPages.Add($tabpage_newuser)

# Configuration de l'événement click du bouton générer
$button_generer.Add_Click({

    if (-not ($Global:VerifPrenom) -or -not ($Global:VerifNom) -or -not ($Global:VerifBureau)) {
        [System.Windows.Forms.MessageBox]::Show("Please ensure all fields are correctly filled out.")
        return
    } else {
        [System.Windows.Forms.MessageBox]::Show("le compte a été envoyé")
    }    

    # Ajout de l'onglet "Onglet B"
    $TabPage2 = New-Object System.Windows.Forms.TabPage
    $TabPage2.Text = "Onglet B"
    $TabControl.TabPages.Add($TabPage2)
    $TabControl.SelectedTab = $TabPage2

    # Récupérer l'utilisateur correspondant au prénom et nom fournis
    $Prenom = $TextBoxPrenom.Text
    $Nom = $TextBoxNom.Text
    $user = Get-ADUser -Filter "GivenName -like '$($Prenom)*' -and Surname -like '$($Nom)*'" -Properties *

    # Vérifier si un utilisateur a été trouvé
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
})

# Affichage du formulaire
[void]$Form10.ShowDialog()
