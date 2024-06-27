# Charger les éléments graphiques nécessaires en mémoire
[void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
$Form10 = New-Object System.Windows.Forms.Form
$TextBoxPrenom = New-Object System.Windows.Forms.TextBox
$TextBoxNom = New-Object System.Windows.Forms.TextBox
$TextTelephone = New-Object System.Windows.Forms.TextBox
$TextBureau = New-Object System.Windows.Forms.TextBox

$LabelPrenom = New-Object System.Windows.Forms.Label
$LabelPrenomError = New-Object System.Windows.Forms.Label
$LabelNom = New-Object System.Windows.Forms.Label
$LabelNomError = New-Object System.Windows.Forms.Label
$LabelTelephone = New-Object System.Windows.Forms.Label
$LabelTelephoneError = New-Object System.Windows.Forms.Label

$labelBureau = New-Object System.Windows.Forms.Label
$labelBureauError = New-Object System.Windows.Forms.Label
$Labelservice = New-Object System.Windows.Forms.Label
$labelMessage = New-Object System.Windows.Forms.Label
$ComboBoxService = New-Object System.Windows.Forms.ComboBox
$ComboBoxPoste = New-Object System.Windows.Forms.ComboBox

# Ajout
$TextBoxLogin = New-Object System.Windows.Forms.TextBox
$LabelLogin = New-Object System.Windows.Forms.Label

$tabcontrol_Cabinet = New-Object System.Windows.Forms.TabControl
$tabpage_newuser = New-Object System.Windows.Forms.TabPage

# Ajout des contrôles au formulaire
$tabpage_newuser.Controls.Add($LabelLogin)
$tabpage_newuser.Controls.Add($TextBoxLogin)
$tabpage_newuser.Controls.Add($LabelNom)
$tabpage_newuser.Controls.Add($LabelNomError)
$tabpage_newuser.Controls.Add($LabelPrenom)
$tabpage_newuser.Controls.Add($LabelPrenomError)
$tabpage_newuser.Controls.Add($LabelTelephone)
$tabpage_newuser.Controls.Add($LabelTelephoneError)
$tabpage_newuser.Controls.Add($labelBureau)
$tabpage_newuser.Controls.Add($labelBureauError)
$tabpage_newuser.Controls.Add($Labelservice)
$tabpage_newuser.Controls.Add($labelMessage)
$tabpage_newuser.Controls.Add($TextTelephone)
$tabpage_newuser.Controls.Add($TextBoxPrenom)
$tabpage_newuser.Controls.Add($TextBoxNom)
$tabpage_newuser.Controls.Add($TextBureau)
$tabpage_newuser.Controls.Add($ComboBoxService)

# Valeurs qui permettent de vérifier les champs nécessaires pour créer un utilisateur
[bool]$Global:VerifPrenom=$false
[bool]$Global:VerifNom=$false
[bool]$Global:VerifBureau=$false
[bool]$Global:VerifTelephone=$false
[bool]$Global:VerifLogin=$false

# Chargement des paramètres du domaine
[string]$settingsFile = "PwdCabinet.xml"

$TextBoxNom.Add_textChanged({
	$TextBoxNom.Text = ($TextBoxNom.Get_Text()).ToUpper()
	$TextBoxNom.SelectionStart = $TextBoxNom.Text.Length
	$TextBoxNom.SelectionLength = 0
})

$TextBoxPrenom.Add_textChanged({
	$TextBoxPrenom.Text = (Get-Culture).TextInfo.ToTitleCase($TextBoxPrenom.Text)
	$TextBoxPrenom.SelectionStart = $TextBoxPrenom.Text.Length
	$TextBoxPrenom.SelectionLength = 0
})

$TextTelephone.Add_LostFocus({
	if ($TextTelephone.Text.Length -eq 0) {
		ChangeLabelOk $LabelTelephoneError
		$Global:VerifTelephone=$false
		return
	} elseif ($TextTelephone.Text.Length -ne 5) {
		ChangeLabelError $LabelTelephoneError 'Merci de mettre que les 5 derniers numéros'
		$Global:VerifTelephone=$false
		return
	}
	try {
		[Int]$TestTelephone=$TextTelephone.Text
	} catch [System.Management.Automation.PSInvalidCastException] {
		$Global:VerifTelephone=$false
		ChangeLabelError $LabelTelephoneError 'Le champ doit contenir que des chiffres'
		return
	}
	$Global:VerifTelephone=$true
	ChangeLabelOk $LabelTelephoneError
})

$TextBoxLogin.Add_LostFocus({
	if ($Global:VerifLogin -eq $true) {
		return
	}
	$Global:VerifLogin = $true
})

$TextBoxLogin.Add_textChanged({
	$TextBoxLogin.Text = ($TextBoxLogin.Get_Text())
	$TextBoxLogin.SelectionStart = $TextBoxLogin.Text.Length
	$TextBoxLogin.SelectionLength = 0
})

$TextBoxPrenom.Add_LostFocus({
	if ($Global:VerifPrenom -eq $true) {
		return
	}
	$chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ '
	for ($i=0; $i -lt ($TextBoxPrenom.Text).Length; $i++) {
		if ($chars -match $TextBoxPrenom.Text[$i] -ne $true) {
			ChangeLabelError $LabelPrenomError 'Le champ doit contenir que des lettres'
			$Global:VerifPrenom = $false
			break
		} else {
			$Global:VerifPrenom = $true
		}
	}
	if ($Global:VerifPrenom -eq $true) {
		ChangeLabelOk $LabelPrenomError
	}
})

$TextBoxNom.Add_LostFocus({
	if ($Global:VerifNom -eq $true) {
		return
	}
	$chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ '
	for ($i=0; $i -lt ($TextBoxNom.Text).Length; $i++) {
		if ($chars -match $TextBoxNom.Text[$i] -ne $true) {
			ChangeLabelError $LabelNomError 'Le champ doit contenir que des lettres'
			$Global:VerifNom = $false
			break
		} else {
			$Global:VerifNom = $true
		}
	}
	if ($Global:VerifNom -eq $true) {
		ChangeLabelOk $LabelNomError
	}
})

$TextBureau.Add_LostFocus({
	$chars = '0123456789'
	for ($i=0; $i -lt ($TextBureau.Text).Length; $i++) {
		if ($chars -match $TextBureau.Text[$i] -ne $true) {
			ChangeLabelError $LabelBureauError 'Le champ doit contenir que des chiffres'
			$Global:VerifBureau = $false
			break
		} elseif ($TextBureau.Text.Length -ne 4) {
			ChangeLabelError $LabelBureauError 'Le champ doit contenir 4 caractères'
			return
		} else {
			ChangeLabelOk $LabelBureauError
			$Global:VerifBureau = $true
		}
	}
})

# Fonction qui permet de prendre les initiales de plusieurs prénoms
function MultiPrenom {
	Param($Prenom=$args[0])
	for ($i=0; $i -lt ($Prenom.Split(' ')).Count; $i++) {
		$MultiPrenom+=$Prenom.Split(' ')[$i][0]
	}
	return $MultiPrenom
}

# Fonction qui permet de prendre l'initiale d'un prénom
function InitialPrenom {
	Param($Prenom=$args[0])
	if (($Prenom.Split(' ')).Count -eq 1) {
		return $Prenom[0]
	} elseif (($Prenom.Split(' ')).Count -ge 2) {
		$InitialPrenom = MultiPrenom $Prenom
		return $InitialPrenom
	}
}

# Fonction pour l'affichage des messages d'erreurs
function ChangeLabelError {
	Param($LabelError=$args[0], $TextError=$args[1])
	$LabelError.ForeColor = 'Red'
	$LabelError.Text = $TextError
}

# Fonction pour l'affichage des messages d'informations
function ChangeLabelOk {
	Param($LabelError=$args[0])
	$LabelError.ForeColor = 'Green'
	$LabelError.Text = 'OK'
}

# Fonction qui génère un mot de passe aléatoire
function Generate-Pwd {
	Param([bool]$chiffres=$args[0], [bool]$minuscules=$args[1], [bool]$majuscules=$args[2], [bool]$autres=$args[3], [int]$len=$args[4])
	[string]$chars = ''
	if ($chiffres -eq 1) {$chars += '0123456789';$complex += 1}
	if ($majuscules -eq 1) {$chars += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';$complex += 1}
	if ($minuscules -eq 1) {$chars += 'abcdefghijklmnopqrstuvwxyz';$complex += 1}
	if ($autres -eq 1) {$chars += '_!@#$%';$complex += 1}
	if ($chars -ne '') {
		$bytes = New-Object 'System.Byte[]' $len
		(New-Object System.Security.Cryptography.RNGCryptoServiceProvider).GetBytes($bytes)
		$pwd = ([String]($bytes.ForEach{$chars[($_ % $chars.Length)]})).ToString()
	} else {
		$pwd = Read-Host "mot de passe"
	}
	return $pwd
}

# Permet de récupérer le login de l'utilisateur
$BouttonValider.Add_Click({
	$InitialPrenom = InitialPrenom $TextBoxPrenom.Text
	$Global:login = "$InitialPrenom$($TextBoxNom.Text)"
	if ($TextBureau.Text.Length -eq 0) {
		ChangeLabelError $LabelBureauError 'Le champ ne peut pas être vide'
	} elseif ($TextTelephone.Text.Length -eq 0) {
		ChangeLabelError $LabelTelephoneError 'Le champ ne peut pas être vide'
	} elseif ($TextBoxPrenom.Text.Length -eq 0) {
		ChangeLabelError $LabelPrenomError 'Le champ ne peut pas être vide'
	} elseif ($TextBoxNom.Text.Length -eq 0) {
		ChangeLabelError $LabelNomError 'Le champ ne peut pas être vide'
	} elseif ($ComboBoxService.SelectedIndex -eq -1) {
		$labelMessage.ForeColor = 'Red'
		$labelMessage.Text = 'Le service doit être selectionné'
	} elseif ($Global:VerifNom -eq $false -or $Global:VerifPrenom -eq $false -or $Global:VerifBureau -eq $false -or $Global:VerifTelephone -eq $false) {
		$labelMessage.ForeColor = 'Red'
		$labelMessage.Text = 'Des champs comportent des erreurs'
	} else {
		$TextBoxLogin.Text = $Global:login.ToLower()
	}
})

# Ajouter les labels et zones de texte au formulaire
$Form10.Controls.Add($tabcontrol_Cabinet)
$tabcontrol_Cabinet.Controls.Add($tabpage_newuser)

# Définir les propriétés de chaque contrôle
$Form10.Text = 'Création utilisateur'
$Form10.Size = New-Object System.Drawing.Size(800, 600)

$tabcontrol_Cabinet.Dock = [System.Windows.Forms.DockStyle]::Fill
$tabpage_newuser.Text = "Nouvel utilisateur"

# Positionnement des contrôles (exemple, ajustez selon vos besoins)
$LabelLogin.Text = "Login :"
$LabelLogin.Location = New-Object System.Drawing.Point(50, 20)
$TextBoxLogin.Location = New-Object System.Drawing.Point(150, 20)

$LabelNom.Text = "Nom :"
$LabelNom.Location = New-Object System.Drawing.Point(50, 60)
$TextBoxNom.Location = New-Object System.Drawing.Point(150, 60)

$LabelPrenom.Text = "Prénom :"
$LabelPrenom.Location = New-Object System.Drawing.Point(50, 100)
$TextBoxPrenom.Location = New-Object System.Drawing.Point(150, 100)

$LabelTelephone.Text = "Téléphone :"
$LabelTelephone.Location = New-Object System.Drawing.Point(50, 140)
$TextTelephone.Location = New-Object System.Drawing.Point(150, 140)

$labelBureau.Text = "Bureau :"
$labelBureau.Location = New-Object System.Drawing.Point(50, 180)
$TextBureau.Location = New-Object System.Drawing.Point(150, 180)

$Labelservice.Text = "Service :"
$Labelservice.Location = New-Object System.Drawing.Point(50, 220)
$ComboBoxService.Location = New-Object System.Drawing.Point(150, 220)

# Ajouter des exemples d'éléments à la ComboBoxService
$ComboBoxService.Items.Add("Service 1")
$ComboBoxService.Items.Add("Service 2")
$ComboBoxService.Items.Add("Service 3")

# Afficher le formulaire
[void]$Form10.ShowDialog()

