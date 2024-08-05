[void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
$Form10 = new-object System.Windows.Forms.form

#
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


#Valeurs qui permettent de vérifier les valeurs des champs necessaires pour créer un utilisateur
[bool]$Global:VerifPrenom=$false
[bool]$Global:VerifNom=$false
[bool]$Global:VerifTelephone=$false

$TextBureau.Add_LostFocus({
	$chars = '0123456789'
	
	for ( $i=0; $i -lt ($TextBureau.text).Length; $i++ ) {
		if ($chars -match $TextBureau.Text[$i] -ne $true) {
			ChangeLabelError $LabelBureauError 'Le champ doit contenir que des chiffres'
			$Global:VerifBureau = $false
			Break
		}
		
		elseif ($TextBureau.Text.Length -ne 4) {
			ChangeLabelError $LabelBureauError 'Le champ doit contenir 4 caractères'
			return
		}
		else {
			ChangeLabelOK $LabelBureauError
			$Global:VerifBureau = $true
		}
	}
})


# Créer une étiquette pour le menu déroulant
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(150, 20)
$label.Text = "Choisissez un bâtiment :"
$tabpage_newuser.Controls.Add($label)

$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = New-Object System.Drawing.Point(170, 20)
$comboBox.Size = New-Object System.Drawing.Size(100, 20)
$comboBox.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList

$options = @("BAT4", "BAT5", "BAT6", "ROQUELAURE", "LEPLAY", "LESDIGUIERE","Autre")
$comboBox.Items.AddRange($options)

$tabpage_newuser.Controls.Add($comboBox)

$LabelBureauError = New-Object System.Windows.Forms.Label
$LabelBureauError.Location = New-Object System.Drawing.Point(340, 65)
$LabelBureauError.Size = New-Object System.Drawing.Size(250, 20)
$LabelBureauError.ForeColor = [System.Drawing.Color]::Red
$tabpage_newuser.Controls.Add($LabelBureauError)


$TextBureau = New-Object System.Windows.Forms.TextBox
$TextBureau.Location = New-Object System.Drawing.Point(150, 65)
$TextBureau.Size = New-Object System.Drawing.Size(45, 30)
$TextBureau.Visible = $false
$tabpage_newuser.Controls.Add($TextBureau)

$LabelBureau = New-Object System.Windows.Forms.Label
$LabelBureau.Location = New-Object System.Drawing.Point(15, 65)
$LabelBureau.Size = New-Object System.Drawing.Size(80, 20)

$LabelBureau.Visible = $false
$tabpage_newuser.Controls.Add($LabelBureau)

$TextBureau_2 = New-Object System.Windows.Forms.TextBox
$TextBureau_2.Location = New-Object System.Drawing.Point(270, 65)
$TextBureau_2.Size = New-Object System.Drawing.Size(45, 30)
$TextBureau_2.Visible = $false
$tabpage_newuser.Controls.Add($TextBureau_2)

$LabelBureau_2 = New-Object System.Windows.Forms.Label
$LabelBureau_2.Location = New-Object System.Drawing.Point(110, 65)
$LabelBureau_2.Size = New-Object System.Drawing.Size(100, 20)
$LabelBureau_2.Text = "étage :"

$LabelBureau_2.Visible = $false
$tabpage_newuser.Controls.Add($LabelBureau_2)

$LabelBureau_3 = New-Object System.Windows.Forms.Label
$LabelBureau_3.Location = New-Object System.Drawing.Point(212, 65)
$LabelBureau_3.Size = New-Object System.Drawing.Size(100, 20)
$LabelBureau_3.Text = "N° Bureau:"

$LabelBureau_3.Visible = $false
$tabpage_newuser.Controls.Add($LabelBureau_3)

$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(300, 20)
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Text = "Valider"
$tabpage_newuser.Controls.Add($button)

$Global:Bureau = ""
$Global:choice =""
$Global:Bureau_2 = ""

$button.Add_Click({
    $selectedOption = $comboBox.SelectedItem    
    $LabelBureau.Visible = $true

    # switchcase pour afficher les batiments 
    switch ($selectedOption) {
        "BAT4" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '4'
            $LabelBureau.Text = "Batiment 4 :"
            $LabelBureau.Visible = $true

            $TextBureau_2.Visible = $true
            $TextBureau_2.Focus()

            $LabelBureau_2.Visible = $true

            $LabelBureau_3.Visible = $true
        }
        "BAT5" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '5'
            $LabelBureau.Text = "Batiment 5 :"
            $LabelBureau.Visible = $true

            $TextBureau_2.Visible = $true
            $TextBureau_2.Focus()

            $LabelBureau_2.Visible = $true

            $LabelBureau_3.Visible = $true
        }
        "BAT6" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '6'
            $LabelBureau.Text = "Batiment 6 :"
            $LabelBureau.Visible = $true

            $TextBureau_2.Visible = $true
            $TextBureau_2.Focus()

            $LabelBureau_2.Visible = $true

            $LabelBureau_3.Visible = $true
        }
        "ROQUELAURE" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = 'ROQ'
            $LabelBureau.Text = "Roquelaure :"
            $LabelBureau.Visible = $true

            $TextBureau_2.Visible = $true
            $TextBureau_2.Focus()

            $LabelBureau_2.Visible = $true

            $LabelBureau_3.Visible = $true
        }
        "LEPLAY" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '7'
            $LabelBureau.Text = "Leplay :"
            $LabelBureau.Visible = $true

            $TextBureau_2.Visible = $true
            $TextBureau_2.Focus()

            $LabelBureau_2.Visible = $true

            $LabelBureau_3.Visible = $true
        }
        "LESDIGUIERE" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = 'LES'
            $LabelBureau.Text = "Lesdiguiere :"
            $LabelBureau.Visible = $true 

            $TextBureau_2.Visible = $true
            $TextBureau_2.Focus()

            $LabelBureau_2.Visible = $true

            $LabelBureau_3.Visible = $true
        }
        "Autre" {
            $TextBureau.Size = New-Object System.Drawing.Size(205, 30)
            $LabelBureau.Size = New-Object System.Drawing.Size(100, 20)

            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = ''
            $LabelBureau.Text = "Saisie Manuelle "
            $LabelBureau.Visible = $true
        }
        default { 
            $TextBureau.Visible = $false
            [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : $selectedOption") 
        }
    }
})

$TextBureau.Add_LostFocus({
    $Global:Bureau = $TextBureau.Text.Trim()
    $selectedOption = $comboBox.SelectedItem

    if ($Global:Bureau -ne $null) {
        $Global:VerifBureau = $false

        #### test console
        Write-Host "c est Bureau: '$Global:Bureau'"
        Write-Host "Length: $($Global:Bureau.Length)"
        ####

        # Ignore les conditions si "Saisie Manuelle"
        if ($selectedOption -eq "Autre") {
            $LabelBureauError.Text = ''
            $Global:VerifBureau = $true
        }
	
        else {
            # Vérifie les conditions 
            if ($Global:Bureau.Length -ne 1) {
                $LabelBureauError.Text = "Le premier champ ne doit contenir qu'1 chiffre"
            } elseif ($Global:Bureau -notmatch '^[0-9]+$') {
                $LabelBureauError.Text = "Le premier champ ne doit contenir qu'1 chiffre"
            } else {
                $LabelBureauError.Text = ''
                $Global:VerifBureau = $true
                $Global:bur = "$Global:choice" + "$Global:Bureau"
            }
        }
    } elseif ($comboBox.SelectedItem -eq "Saisie Manuelle") {
        $Global:VerifBureau = $true
        $Global:bur = "$Global:choice" + "$Global:Bureau"
    } else {
        $LabelBureauError.Text = 'Le champ ne peut pas être vide'
        #### test console
        Write-Host "TextBox est null ou TextBox.Text est null"
        ####
    }
    $Global:bur = "$Global:choice" + "$Global:Bureau"
    
    #### test  console
    Write-Host "c est Bureau: '$Global:Bureau'"
    Write-Host "Length: $($Global:Bureau.Length)"
    Write-Host "$Global:bur"
    Write-Host "Verification: $Global:VerifBureau"
    #######
    
        
})

TextBureau_2.Add_LostFocus({
    
    $PrintBur = New-Object System.Windows.Forms.Label
    $PrintBur.Location = New-Object System.Drawing.Point(320, 65)
    $PrintBur.Size = New-Object System.Drawing.Size(100, 20)
    $PrintBur.Text = "$Global:bur2"
    $Global:burtest = "$Global:bur" + "$Global:bur2"

    $PrintBur.Visible = $false
    $tabpage_newuser.Controls.Add($PrintBur)

    $Global:Bureau_2 = $TextBureau_2.Text.Trim()
    $selectedOption = $comboBox.SelectedItem
    $Global:bur2 = "$Global:bur" + "$Global:Bureau_2"
    if ($Global:Bureau_2 -ne $null) {
        $Global:VerifBureau_2 = $false

        #### test console
        Write-Host "c est Bureau: '$Global:Bureau_2'"
        Write-Host "Length: $($Global:Bureau_2.Length)"
        ####

        # Ignore les conditions si "Saisie Manuelle"
        if ($selectedOption -eq "Autre") {
            $LabelBureauError.Text = ''
            $Global:VerifBureau_2 = $true
        }
	
        else {
            # Vérifie les conditions 
            if ($Global:Bureau_2.Length -ne 2) {
                $LabelBureauError.Text = "Le second champ ne doit contenir que 2 chiffres"
            } elseif ($Global:Bureau -notmatch '^[0-9]+$') {
                $LabelBureauError.Text = 'Le champ doit contenir uniquement des chiffres'
            } else {
                $LabelBureauError.Text = ''
                $Global:VerifBureau_2 = $true
                $Global:bur2 = "$Global:bur" + "$Global:Bureau_2"

                $PrintBur = New-Object System.Windows.Forms.Label
                $PrintBur.Location = New-Object System.Drawing.Point(320, 85)
                $PrintBur.Size = New-Object System.Drawing.Size(50, 20)
                $PrintBur.Text = "Numéro de bureau $Global:bur2"
                $tabpage_newuser.Controls.Add($PrintBur)

                $PrintBur.Visible = $false

                if ( $Global:burtest-match '^\d{3}$'){
                    $Global:VfBur = $true
                    $PrintBur.Visible = $true
                    Write-Host "Verification: $Global:burtest"
                    
                }  
                
                
            }
        }
    } elseif ($comboBox.SelectedItem -eq "Saisie Manuelle") {
        $Global:VfBur = $true
        $Global:bur2 = "$Global:bur" + "$Global:Bureau_2"
    } else {
        $LabelBureauError.Text = 'Le champ ne peut pas être vide'
        #### test console
        Write-Host "TextBox est null ou TextBox.Text est null"
        ####
    }
    $Global:bur2 = "$Global:bur" + "$Global:Bureau_2"

    
    #### test  console
    Write-Host "c est Bureau: '$Global:Bureau_2'"
    Write-Host "Length: $($Global:Bureau_2.Length)"
    Write-Host "$Global:bur2"
    Write-Host "Verification: $Global:VerifBureau_2"
    Write-Host "test bureau $Global:burtest"
    #######
    
       
})
#############

TextBureau_2.Add_LostFocus : Le terme «TextBureau_2.Add_LostFocus» n'est pas reconnu comme nom d'applet de commande, fonction, fichier de script 
ou programme exécutable. Vérifiez l'orthographe du nom, ou si un chemin d'accès existe, vérifiez que le chemin d'accès est correct et réessayez.
Au caractère C:\Scripts\Alexis\scr1_02_08.ps1:482 : 1
+ TextBureau_2.Add_LostFocus({
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (TextBureau_2.Add_LostFocus:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
 