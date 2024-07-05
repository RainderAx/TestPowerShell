# Importer le module Windows Forms
Add-Type -AssemblyName System.Windows.Forms

##########################################################
$TextBoxBureau = New-Object System.Windows.Forms.TextBox
$LabelBureau = New-Object System.Windows.Forms.Label
$tabpage_newuser.Controls.Add($LabelLogin)
$tabpage_newuser.Controls.Add($TextBoxLogin)
[bool]$Global:VerifBureau=$false

$TextBureau.Add_LostFocus({
	$chars = '0123456789'
	
	for ( $i=0; $i -lt ($TextBureau.text).Length; $i++ ) {
		if ($chars -match $TextBureau.Text[$i] -ne $true) {
			ChangeLabelError $LabelBureauError 'Le champ doit contenir que des chiffres'
			$Global:VerifBureau = $false
			Break
		}
		
		elseif ($TextBureau.Text.Length -ne 3) {
			ChangeLabelError $LabelBureauError 'Le champ doit contenir 3 caractÃ¨res'
			return
		}
		else {
			ChangeLabelOK $LabelBureauError
			$Global:VerifBureau = $true
		}
	}
})


########################################################


# Créer la fenêtre
$form = New-Object System.Windows.Forms.Form
$form.Text = "Exemple de Menu Déroulant"
$form.Size = New-Object System.Drawing.Size(300, 150)

# Créer une étiquette pour le menu déroulant
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(150, 20)
$label.Text = "Choisissez une option :"
$form.Controls.Add($label)

# Créer le menu déroulant (ComboBox)
$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = New-Object System.Drawing.Point(170, 20)
$comboBox.Size = New-Object System.Drawing.Size(100, 20)
$comboBox.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList

# Ajouter des options au menu déroulant
$options = @("BAT4", "BAT5", "BAT6", "ROQUELAURE", "LEPLAY", "LESDIGUIERE")
$comboBox.Items.AddRange($options)

# Ajouter le ComboBox à la fenêtre
$form.Controls.Add($comboBox)

# Créer un bouton pour valider la sélection
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(10, 60)
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Text = "Valider"
$form.Controls.Add($button)

# Ajouter un événement au bouton pour afficher la sélection
$button.Add_Click({
    $selectedOption = $comboBox.SelectedItem

    switch ($selectedOption) {
        "BAT4" {    [String]$Bureau='4',$TextBureau.Get_text().Trim(' ')
        
                    # LabelBureau
                    $LabelBureau.AutoSize = $true
                    $LabelBureau.Location = New-Object System.Drawing.Point(15, 25)
                    $LabelBureau.Name = 'LabelBureau'
                    $LabelBureau.Size = New-Object System.Drawing.Size(71, 13)
                    $LabelBureau.Text = 'Batiment  4'
                    #
                    # LabelBureauerror
                    #
                    $LabelBureauerror.AutoSize = $true
                    $LabelBureauerror.Location = New-Object System.Drawing.Point(375, 25)
                    $LabelBureauerror.Name = 'LabelBureauerror'
                    $LabelBureauerror.Size = New-Object System.Drawing.Size(71, 13)
                    $LabelBureauerror.Text = '' }




        "BAT5" { [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : Option 2") }

        "BAT6" { [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : Option 3") }

        "ROQUELAURE" { [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : Option 4") }

        "LEPLAY" { [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : Option 4") }

        "LESDIGUIERE" { [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : Option 4") }

        default { [System.Windows.Forms.MessageBox]::Show("Option non reconnue") }
    }
})

# Afficher la fenêtre
$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()
