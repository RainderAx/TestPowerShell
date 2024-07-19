#Valeurs qui permettent de vÃ©rifier les valeurs des champs necessaires pour crÃ©er un utilisateur
[bool]$Global:VerifPrenom=$false
[bool]$Global:VerifNom=$false
[bool]$Global:VerifTelephone=$false

#Chargement parametre domaine 
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
		$Global:VerifTelephone=$false
		return
	}
	
	elseif ($TextTelephone.Text.Length -ne 5) {
		ChangeLabelError $LabelTelephoneError 'Merci de mettre que les 5 derniers numeros'
		$Global:VerifTelephone=$false
		return
	}
	
	Try {
	[Int]$TestTelephone=$TextTelephone.Text
	}	
	
	Catch [System.Management.Automation.PSInvalidCastException] {
		$Global:VerifTelephone=$false
		ChangeLabelError $LabelTelephoneError 'Le champ doit contenir que des chiffres'
		return
	}
	$Global:VerifTelephone=$true
	ChangeLabelOk $LabelTelephoneError
})

###


$TextBoxPrenom.Add_LostFocus({
	
	if ($Global:VerifPrenom -eq $true) {
		return
	}
	
	$chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ '
	
	for ( $i=0; $i -lt ($TextBoxPrenom.text).Length; $i++ ) {
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
	
	for ( $i=0; $i -lt ($TextBoxNom.text).Length; $i++ ) {
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

#############

# Créer une étiquette pour le menu déroulant
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(150, 20)
$label.Text = "Choisissez un bâtiment :"
$tabpage_newuser.Controls.Add($label)

# Créer le menu déroulant (ComboBox)
$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = New-Object System.Drawing.Point(170, 20)
$comboBox.Size = New-Object System.Drawing.Size(100, 20)
$comboBox.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList

# Ajouter des options au menu déroulant
$options = @("BAT4", "BAT5", "BAT6", "ROQUELAURE", "LEPLAY", "LESDIGUIERE")
$comboBox.Items.AddRange($options)

# Ajouter le ComboBox à la fenêtre
$tabpage_newuser.Controls.Add($comboBox)

# Créer une étiquette pour afficher les erreurs
$LabelBureauError = New-Object System.Windows.Forms.Label
$LabelBureauError.Location = New-Object System.Drawing.Point(240, 65)
$LabelBureauError.Size = New-Object System.Drawing.Size(400, 20)
$LabelBureauError.ForeColor = [System.Drawing.Color]::Red
$tabpage_newuser.Controls.Add($LabelBureauError)

# Créer un TextBox pour le bureau et le rendre invisible par défaut
$TextBureau = New-Object System.Windows.Forms.TextBox
$TextBureau.Location = New-Object System.Drawing.Point(150, 65)
$TextBureau.Size = New-Object System.Drawing.Size(205, 30)
$TextBureau.Visible = $false
$tabpage_newuser.Controls.Add($TextBureau)

# Créer une étiquette pour afficher le bureau
$LabelBureau = New-Object System.Windows.Forms.Label
$LabelBureau.Location = New-Object System.Drawing.Point(15, 65)
$LabelBureau.Size = New-Object System.Drawing.Size(100, 20)

$LabelBureau.Visible = $false
$tabpage_newuser.Controls.Add($LabelBureau)


# Créer un bouton pour valider la sélection
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(300, 20)
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Text = "Valider"
$tabpage_newuser.Controls.Add($button)


# Déclarer une variable globale pour stocker la valeur de Bureau
$Global:Bureau = ""
$Global:choice =""

# Ajouter un événement au bouton pour afficher la sélection
$button.Add_Click({
    $selectedOption = $comboBox.SelectedItem

    # Mettre à jour l'étiquette LabelBureau en fonction de l'option choisie
    
    $LabelBureau.Visible = $true

#switchcase pour afficher les batiments 
    switch ($selectedOption) {
        "BAT4" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '4'
            $LabelBureau.Text = "Batiment 4 :"
            $LabelBureau.Visible = $true
        }
        "BAT5"{
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '5'
            $LabelBureau.Text = "Batiment 5 :"
            $LabelBureau.Visible = $true
        }

        "BAT6"{
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '6'
            $LabelBureau.Text = "Batiment 6 :"
            $LabelBureau.Visible = $true
        }

        "ROQUELAURE"{
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = 'ROQ'
            $LabelBureau.Text = "Roquelaure :"
            $LabelBureau.Visible = $true
        }

        "LEPLAY"{
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '7'
            $LabelBureau.Text = "Leplay :"
            $LabelBureau.Visible = $true
        }

        "LESDIGUIERE"{
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = 'LES'
            $LabelBureau.Text = "Lesdiguiere :"
            $LabelBureau.Visible = $true 
        }
        default { 
            $TextBureau.Visible = $false
            [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : $selectedOption") 
        }
    }
})

# Ajouter un événement LostFocus au TextBox pour la validation
$TextBureau.Add_LostFocus({
    $Global:Bureau = $TextBureau.Text.Trim()

    # Ajouter une vérification et un message de débogage
    if ($Global:Bureau -ne $null) {
        $Global:VerifBureau = $false

        Write-Host "c est Bureau: '$Global:Bureau'"
        Write-Host "Length: $($Global:Bureau.Length)"

        # Vérifier si la longueur du texte est de 3 caractères
        if ($Global:Bureau.Length -ne 3) {
            $LabelBureauError.Text = 'Le champ doit contenir 3 caractères'
        } elseif ($Global:Bureau -notmatch '^[0-9]+$') {
            # Vérifier si le texte contient uniquement des chiffres
            $LabelBureauError.Text = 'Le champ doit contenir uniquement des chiffres'

        } else {
            # Si toutes les conditions sont remplies
            $LabelBureauError.Text = ''
            $Global:VerifBureau = $true
            $bur = "$Global:choice" + "$Global:Bureau"
        }
    } else {
        $LabelBureauError.Text = 'Le champ ne peut pas être vide'
        Write-Host "TextBox est null ou TextBox.Text est null"
    }
    Write-Host "c est Bureau: '$Global:Bureau'"
    Write-Host "Length: $($Global:Bureau.Length)"
    Write-Host "$bur"
})

#############

$button_generer.Add_Click({

    
	if (($Global:VerifPrenom -eq 0) -or ($Global:VerifNom -eq 0) -or ($Global:Bureau -eq $true)) {
		
        return
	}