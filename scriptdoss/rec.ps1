# Adding a button to the tab page
$tabpage_newuser.Controls.Add($button)

# Handling the button click event
$button.Add_Click({
    $selectedOption = $comboBox.SelectedItem

    # Defining the TextBox LostFocus event handler within the button click event
    $TextBureau_LostFocus = {
        $chars = '0123456789'
        $TextBureauText = $TextBureau.Text
        $isNumeric = $TextBureauText -cmatch '^[0-9]{3}$'
        
        if (-not $isNumeric) {
            if ($TextBureauText.Length -ne 3) {
                ChangeLabelError $LabelBureauError 'Le champ doit contenir 3 caractères'
            } else {
                ChangeLabelError $LabelBureauError 'Le champ doit contenir que des chiffres'
            }
            $Global:VerifBureau = $false
        } else {
            ChangeLabelOK $LabelBureauError
            $Global:VerifBureau = $true
        }
    }

    switch ($selectedOption) {
        "BAT4" {
            # Creating a TextBox for the bureau
            $TextBureau = New-Object System.Windows.Forms.TextBox
            $TextBureau.Location = New-Object System.Drawing.Point(150, 55)
            $TextBureau.Size = New-Object System.Drawing.Size(200, 20)
            $TextBureau.MaxLength = 3
            $TextBureau.Name = 'TextBureau'
            $TextBureau.TabIndex = 1
            $tabpage_newuser.Controls.Add($TextBureau)
            
            # Assigning the LostFocus event to the TextBox
            $TextBureau.Add_LostFocus($TextBureau_LostFocus)

            # Creating a label for the bureau
            $LabelBureau = New-Object System.Windows.Forms.Label
            $LabelBureau.Location = New-Object System.Drawing.Point(15, 50)
            $LabelBureau.Size = New-Object System.Drawing.Size(150, 20)
            $LabelBureau.Text = "Bâtiment 4"
            $tabpage_newuser.Controls.Add($LabelBureau)

            # Creating an error label for the bureau
            $LabelBureauError = New-Object System.Windows.Forms.Label
            $LabelBureauError.Location = New-Object System.Drawing.Point(15, 75)
            $LabelBureauError.Size = New-Object System.Drawing.Size(335, 20)
            $LabelBureauError.Text = "Entrez les 3 derniers chiffres du bureau"
            $tabpage_newuser.Controls.Add($LabelBureauError)
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
