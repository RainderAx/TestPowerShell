# Charge en mémoire les éléments graphiques necessaires
[void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
$Form10 = new-object System.Windows.Forms.form

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

#ajout
$TextBoxLogin = New-Object System.Windows.Forms.TextBox
$LabelLogin = New-Object System.Windows.Forms.Label

$tabcontrol_Cabinet = New-Object System.Windows.Forms.TabControl
$tabpage_newuser = New-Object System.Windows.Forms.TabPage

$tabpage_newuser.Controls.Add($LabelNom)
$tabpage_newuser.Controls.Add($LabelNomError)
$tabpage_newuser.Controls.Add($LabelPrenom)
$tabpage_newuser.Controls.Add($LabelPrenomError)
$tabpage_newuser.Controls.Add($LabelTelephone)
$tabpage_newuser.Controls.Add($LabelTelephoneError)
$tabpage_newuser.Controls.Add($LabelPoste)
$tabpage_newuser.Controls.Add($Labelservice)
$tabpage_newuser.Controls.Add($LabelMessage)
$tabpage_newuser.Controls.Add($button_quitter)
$tabpage_newuser.Controls.Add($button_generer)
$tabpage_newuser.Controls.Add($TextTelephone)
$tabpage_newuser.Controls.Add($TextBoxPrenom)
$tabpage_newuser.Controls.Add($TextBoxNom)
$tabpage_newuser.Controls.Add($ComboBoxPoste)
$tabpage_newuser.Controls.Add($ComboBoxService)

$tabcontrol_Cabinet.TabPages.Add($tabpage_newuser)

# Valeurs qui permettent de vérifier les valeurs des champs necessaires pour créer un utilisateur
[bool]$Global:VerifPrenom = $false
[bool]$Global:VerifNom = $false
[bool]$Global:VerifTelephone = $false

# Chargement parametre domaine 
[string]$settingsFile = "PwdCabinet.xml" 

$TextBoxNom.Add_textChanged({
    $TextBoxNom.Text = ($TextBoxNom.Get_Text()).ToUpper()
    $TextBoxNom.SelectionStart = $TextBoxNom.Text.Length
    $TextBoxNom.SelectionLength = 0
})

$TextBoxPrenom.Add_textChanged({
    $TextBoxPrenom.Text = (Get-Culture).textinfo.totitlecase($TextBoxPrenom.Text.Split(' '))
    $TextBoxPrenom.SelectionStart = $TextBoxPrenom.Text.Length
    $TextBoxPrenom.SelectionLength = 0
})

$TextTelephone.Add_LostFocus({
    if ($TextTelephone.Text.Length -eq 0) {
        ChangeLabelOk $LabelTelephoneError
        $Global:VerifTelephone = $false
        return
    }
    elseif ($TextTelephone.Text.Length -ne 5) {
        ChangeLabelError $LabelTelephoneError 'Merci de mettre que les 5 derniers numeros'
        $Global:VerifTelephone = $false
        return
    }
    Try {
        [Int]$TestTelephone = $TextTelephone.Text
    }   
    Catch [System.Management.Automation.PSInvalidCastException] {
        $Global:VerifTelephone = $false
        ChangeLabelError $LabelTelephoneError 'Le champ doit contenir que des chiffres'
        return
    }
    $Global:VerifTelephone = $true
    ChangeLabelOk $LabelTelephoneError
})

$TextBoxPrenom.Add_LostFocus({
    if ($Global:VerifPrenom -eq $true) {
        return
    }
    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ '
    for ($i = 0; $i -lt ($TextBoxPrenom.text).Length; $i++) {
        if ($chars -match $TextBoxPrenom.Text[$i] -ne $true) {
            ChangeLabelError $LabelPrenomError 'Le champ doit contenir que des lettres'
            $Global:VerifPrenom = $false
            Break
        }
        else {
            $Global:VerifPrenom = $true
        }
    }
    if ($Global:VerifPrenom -eq $true) {
        ChangeLabelOK $LabelPrenomError 
    }
})

$TextBoxNom.Add_LostFocus({
    if ($Global:VerifNom -eq $true) {
        return
    }
    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ '
    for ($i = 0; $i -lt ($TextBoxNom.text).Length; $i++) {
        if ($chars -match $TextBoxNom.Text[$i] -ne $true) {
            ChangeLabelError $LabelNomError 'Le champ doit contenir que des lettres'
            $Global:VerifNom = $false
            Break
        }
        else {
            $Global:VerifNom = $true
        }
    }
    if ($Global:VerifNom -eq $true) {
        ChangeLabelOK $LabelNomError
    }
})

# Fonction qui permet de prendre les initials de plusieurs prénoms
function MultiPrenom {
    Param($Prenom=$args[0])
    for ($i=0; $i -lt ($Prenom.Split(' ')).Count; $i++) {
        $MultiPrenom += $Prenom.Split(' ')[$i][0]
    }
    return $MultiPrenom
}

# Fonction qui permet de prendre l' initial d'un prenom
function InitialPrenom {
    Param($Prenom=$args[0])
    if (($Prenom.Split(' ')).Count -eq 1) {
        return $Prenom[0]
    }
    elseif (($Prenom.Split(' ')).Count -ge 2) {
        $InitialPrenom = MultiPrenom $Prenom
        return $InitialPrenom
    }
}

# Fonction pour l'affichage des messages d'erreurs
Function ChangeLabelError {
    Param($LabelError=$args[0], $TextError=$args[1])
    $LabelError.Forecolor = 'Red'
    $LabelError.text = $TextError
}

# Fonction pour l'affichage des messages d'informations
Function ChangeLabelOk {
    Param($LabelError=$args[0])
    $LabelError.Forecolor = 'Green'
    $LabelError.text = 'OK'
}

# Fonction qui génère un mot de passe aléatoire
function Generate-Pwd {
    Param([bool]$chiffres=$args[0], [bool]$minuscules=$args[1], [bool]$majuscules=$args[2], [bool]$autres=$args[3], [int]$len=$args[4])
    [string]$chars = ''
    if ($chiffres -eq 1) {$chars += '0123456789';$complex += 1}
    if ($majuscules -eq 1) {$chars += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';$complex += 1}
    if ($minuscules -eq 1) {$chars += 'abcdefghijklmnopqrstuvwxyz';$complex += 1}
    if ($autres -eq 1) {$chars += '_!@#$%';$complex += 1}
    if($chars -ne '') {
        $bytes = new-object 'System.Byte[]' $len
        $rnd = new-object System.Security.Cryptography.RNGCryptoServiceProvider
        $rnd.GetBytes($bytes)
        $result = ''
        for ($i=0; $i -lt $len; $i++) {
            $result += $chars[ $bytes[$i] % $chars.Length ]
        }
        return $result
    }
}

Function Get-InfoDomaine {
    Param($strCategory=$args[0], $DirectoryEntry=$args[1], $Element=$arg[2], $Scope=$arg[3])
    $objDomain = New-Object System.DirectoryServices.DirectoryEntry($DirectoryEntry)
    $objSearcher = New-Object System.DirectoryServices.DirectorySearcher($objDomain,"(objectCategory=$strCategory)",@('name'))
    if ($Element -eq 'Name') {
        if ($Scope -ne $null) {
            $objSearcher.SearchScope = $Scope
        }   
        $Clients=$objSearcher.FindAll() | %{$_.properties.name} 
    }
    elseif ($Element -eq 'adspath') {
        $Clients=$objSearcher.FindAll() | %{$_.properties.adspath} 
    }
    Return $Clients
}

#############
# Créer une étiquette pour le menu déroulant
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(150, 20)
$label.Text = "Sélectionnez un bureau :"

$Form10.Controls.Add($tabcontrol_Cabinet)
$tabcontrol_Cabinet.Location = New-Object System.Drawing.Size(10,10)
$tabcontrol_Cabinet.Size = New-Object System.Drawing.Size(560, 445)
$tabcontrol_Cabinet.SelectedIndex = 0

$tabpage_newuser.Location = New-Object System.Drawing.Size(4, 22)
$tabpage_newuser.Size = New-Object System.Drawing.Size(492, 241)
$tabpage_newuser.Text = "Nouvel Utilisateur"
$tabpage_newuser.TabIndex = 0
$tabpage_newuser.UseVisualStyleBackColor = $true

# Positionnement des étiquettes et boîtes de texte sur le formulaire
$LabelPrenom.AutoSize = $true
$LabelPrenom.Location = New-Object System.Drawing.Point(15, 105)
$LabelPrenom.Name = "LabelPrenom"
$LabelPrenom.Size = New-Object System.Drawing.Size(100, 23)
$LabelPrenom.TabIndex = 2
$LabelPrenom.Text = "Prenom"

$LabelPrenomError.AutoSize = $true
$LabelPrenomError.Location = New-Object System.Drawing.Point(375, 105)
$LabelPrenomError.Name = "LabelPrenomError"
$LabelPrenomError.Size = New-Object System.Drawing.Size(100, 23)
$LabelPrenomError.TabIndex = 3
$LabelPrenomError.Text = ""

$LabelNom.AutoSize = $true
$LabelNom.Location = New-Object System.Drawing.Point(15, 155)
$LabelNom.Name = "LabelNom"
$LabelNom.Size = New-Object System.Drawing.Size(100, 23)
$LabelNom.TabIndex = 4
$LabelNom.Text = "Nom"

$LabelNomError.AutoSize = $true
$LabelNomError.Location = New-Object System.Drawing.Point(375, 155)
$LabelNomError.Name = "LabelNomError"
$LabelNomError.Size = New-Object System.Drawing.Size(100, 23)
$LabelNomError.TabIndex = 5
$LabelNomError.Text = ""

$LabelTelephone.AutoSize = $true
$LabelTelephone.Location = New-Object System.Drawing.Point(15, 255)
$LabelTelephone.Name = "LabelTelephone"
$LabelTelephone.Size = New-Object System.Drawing.Size(100, 23)
$LabelTelephone.TabIndex = 6
$LabelTelephone.Text = "Telephone (optionel)"

$LabelPoste.AutoSize = $true
$LabelPoste.Location = New-Object System.Drawing.Point(15, 305)
$LabelPoste.Name = "LabelPoste"
$LabelPoste.Size = New-Object System.Drawing.Size(100, 23)
$LabelPoste.TabIndex = 7
$LabelPoste.Text = "Poste"

$LabelTelephoneError.AutoSize = $true
$LabelTelephoneError.Location = New-Object System.Drawing.Point(260, 255)
$LabelTelephoneError.Name = "LabelTelephoneError"
$LabelTelephoneError.Size = New-Object System.Drawing.Size(100, 23)
$LabelTelephoneError.TabIndex = 8
$LabelTelephoneError.Text = ""

$button_quitter.Location = New-Object System.Drawing.Point(450, 400)
$button_quitter.Name = "button_quitter"
$button_quitter.Size = New-Object System.Drawing.Size(100, 23)
$button_quitter.TabIndex = 1
$button_quitter.Text = "Quitter"
$button_quitter.Add_Click({$Form10.close()})

$button_generer.Location = New-Object System.Drawing.Point(53, 400)
$button_generer.Name = "button_generer"
$button_generer.Size = New-Object System.Drawing.Size(100, 23)
$button_generer.TabIndex = 0
$button_generer.Text = "Generer"

$TextTelephone.Location = New-Object System.Drawing.Point(155, 255)
$TextTelephone.Name = "TextTelephone"
$TextTelephone.Size = New-Object System.Drawing.Size(100, 23)
$TextTelephone.TabIndex = 9

$TextBoxPrenom.Location = New-Object System.Drawing.Point(155, 105)
$TextBoxPrenom.Name = "TextBoxPrenom"
$TextBoxPrenom.Size = New-Object System.Drawing.Size(200, 23)
$TextBoxPrenom.TabIndex = 10

$TextBoxNom.Location = New-Object System.Drawing.Point(155, 155)
$TextBoxNom.Name = "TextBoxNom"
$TextBoxNom.Size = New-Object System.Drawing.Size(200, 23)
$TextBoxNom.TabIndex = 11

$ComboBoxPoste.Location = New-Object System.Drawing.Point(155, 305)
$ComboBoxPoste.Name = "ComboBoxPoste"
$ComboBoxPoste.Size = New-Object System.Drawing.Size(200, 23)
$ComboBoxPoste.TabIndex = 12

$Labelservice.AutoSize = $true
$Labelservice.Location = New-Object System.Drawing.Point(15, 355)
$Labelservice.Name = "Labelservice"
$Labelservice.Size = New-Object System.Drawing.Size(100, 23)
$Labelservice.TabIndex = 13
$Labelservice.Text = "Service"

$ComboBoxService.Location = New-Object System.Drawing.Point(155, 355)
$ComboBoxService.Name = "ComboBoxService"
$ComboBoxService.Size = New-Object System.Drawing.Size(200, 23)
$ComboBoxService.TabIndex = 14

$labelMessage.AutoSize = $true
$labelMessage.Location = New-Object System.Drawing.Point(100, 70)
$labelMessage.Name = "labelMessage"
$labelMessage.Size = New-Object System.Drawing.Size(400, 23)
$labelMessage.TabIndex = 15
$labelMessage.Text = "Vous devez remplir le Nom, Prenom et Telephone"

$tabpage_newuser.Controls.Add($label)
$tabpage_newuser.Controls.Add($ComboBoxService)
$tabpage_newuser.Controls.Add($ComboBoxPoste)
$tabpage_newuser.Controls.Add($TextBoxNom)
$tabpage_newuser.Controls.Add($TextBoxPrenom)
$tabpage_newuser.Controls.Add($TextTelephone)
$tabpage_newuser.Controls.Add($button_generer)
$tabpage_newuser.Controls.Add($button_quitter)
$tabpage_newuser.Controls.Add($labelMessage)
$tabpage_newuser.Controls.Add($Labelservice)
$tabpage_newuser.Controls.Add($LabelPoste)
$tabpage_newuser.Controls.Add($LabelTelephoneError)
$tabpage_newuser.Controls.Add($LabelTelephone)
$tabpage_newuser.Controls.Add($LabelNomError)
$tabpage_newuser.Controls.Add($LabelNom)
$tabpage_newuser.Controls.Add($LabelPrenomError)
$tabpage_newuser.Controls.Add($LabelPrenom)

# Ajout de l'événement de clic pour le bouton "Generer"
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
    $tabcontrol_Cabinet.TabPages.Add($TabPage2)
    $tabcontrol_Cabinet.SelectedTab = $TabPage2

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

        $OngletBLabelPhone = New-Object System.Windows.Forms.Label
        $OngletBLabelPhone.Location = New-Object System.Drawing.Point(30, 110)
        $OngletBLabelPhone.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelPhone.Text = "Numéro de téléphone: $telephoneNumber"

        $OngletBLabelTitle = New-Object System.Windows.Forms.Label
        $OngletBLabelTitle.Location = New-Object System.Drawing.Point(30, 140)
        $OngletBLabelTitle.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelTitle.Text = "Poste: $Title"

        $OngletBLabelLog = New-Object System.Windows.Forms.Label
        $OngletBLabelLog.Location = New-Object System.Drawing.Point(30, 170)
        $OngletBLabelLog.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelLog.Text = "Login: $log"

        $TabPage2.Controls.Add($OngletBLabelPrenom)
        $TabPage2.Controls.Add($OngletBLabelMail)
        $TabPage2.Controls.Add($OngletBLabelAccExp)
        $TabPage2.Controls.Add($OngletBLabelPhone)
        $TabPage2.Controls.Add($OngletBLabelTitle)
        $TabPage2.Controls.Add($OngletBLabelLog)
    } else {
        [System.Windows.Forms.MessageBox]::Show("Utilisateur non trouvé.")
    }
})

# Affichage du formulaire
$Form10.StartPosition = "CenterScreen"
$Form10.width = 600
$Form10.height = 500
$Form10.Topmost = $true
$Form10.Add_Shown({$Form10.Activate()})
$Form10.Add_Load({
    $ComboBoxPoste.Items.AddRange(@('Poste 1', 'Poste 2', 'Poste 3'))
    $ComboBoxService.Items.AddRange(@('Service 1', 'Service 2', 'Service 3'))
})
[void]$Form10.ShowDialog()


