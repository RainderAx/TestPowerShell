# Importer le module Windows Forms
Add-Type -AssemblyName System.Windows.Forms

# Créer la fenêtre
$form = New-Object System.Windows.Forms.Form
$form.Text = "Exemple de Menu Déroulant"
$form.Size = New-Object System.Drawing.Size(300, 200)

# Créer une étiquette pour le menu déroulant
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(150, 20)
$label.Text = "Choisissez un batiment :"
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

$TextBureau.Add_LostFocus({
	$chars = '0123456789'
	
	for ( $i=0; $i -lt ($TextBureau.text).Length; $i++ ) {
		if ($chars -match $TextBureau.Text[$i] -ne $true) {
			ChangeLabelError $LabelBureauError 'Le champ doit contenir que des chiffres'
			$Global:VerifBureau = $false
			Break
		}
		
		elseif ($TextBureau.Text.Length -ne 3) {
			ChangeLabelError $LabelBureauError 'Le champ doit contenir 4 caractÃ¨res'
			return
		}
		else {
			ChangeLabelOK $LabelBureauError
			$Global:VerifBureau = $true
		}
	}
})

# Créer une étiquette pour afficher les erreurs
$LabelBureauError = New-Object System.Windows.Forms.Label
$LabelBureauError.Location = New-Object System.Drawing.Point(10, 80)
$LabelBureauError.Size = New-Object System.Drawing.Size(260, 20)
$LabelBureauError.ForeColor = [System.Drawing.Color]::Red
$form.Controls.Add($LabelBureauError)

# Créer un bouton pour valider la sélection
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(10, 110)
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Text = "Valider"
$form.Controls.Add($button)



# Ajouter un événement au bouton pour afficher la sélection
$button.Add_Click({
    $selectedOption = $comboBox.SelectedItem

    switch ($selectedOption) {
        "BAT4" {    
            # Créer un TextBox pour le bureau
            $TextBureau = New-Object System.Windows.Forms.TextBox
            $TextBureau.Location = New-Object System.Drawing.Point(170, 50)
            $TextBureau.Size = New-Object System.Drawing.Size(100, 20)
            $form.Controls.Add($TextBureau)

            # Créer une étiquette pour le bureau
            $LabelBureau = New-Object System.Windows.Forms.Label
            $LabelBureau.Location = New-Object System.Drawing.Point(10, 50)
            $LabelBureau.Size = New-Object System.Drawing.Size(150, 20)
            $LabelBureau.Text = "Bureau :"
            $form.Controls.Add($LabelBureau)

            $LabelBureau.Text = "Bâtiment 4"
            $LabelBureauError.Text = ""

            [String]$bur=$TextBureau.Get_text().Trim(' ')
            $Bureau = '4',$bur

        }
        "BAT5" { 
            [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : BAT5") 
        }
        "BAT6" { 
            [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : BAT6") 
        }
        "ROQUELAURE" { 
            [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : ROQUELAURE") 
        }
        "LEPLAY" { 
            [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : LEPLAY") 
        }
        "LESDIGUIERE" { 
            [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : LESDIGUIERE") 
        }
        default { 
            [System.Windows.Forms.MessageBox]::Show("Option non reconnue") 
        }
    }
})



# Afficher la fenêtre
$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()
