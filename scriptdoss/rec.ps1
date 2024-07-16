$tabpage_newuser.Controls.Add($button)

$button.Add_Click({
    $selectedOption = $comboBox.SelectedItem
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
    switch ($selectedOption) {
        "BAT4" {    

            # Créer un TextBox pour le bureau
            $TextBureau = New-Object System.Windows.Forms.TextBox
            $TextBureau.Location = New-Object System.Drawing.Point(15, 35)
            $TextBureau.Size = New-Object System.Drawing.Size(71, 13)
            $tabpage_newuser.Controls.Add($TextBureau)

            # Créer une étiquette pour le bureau
            $TextBureau.Location = New-Object System.Drawing.Point(150, 55)
            $TextBureau.MaxLength = 20
            $TextBureau.Name = 'TextBureau'
            $TextBureau.Size = New-Object System.Drawing.Size(200, 20)
            $TextBureau.TabIndex = 1
            
            # Créer une étiquette pour le bureau
            $LabelBureau = New-Object System.Windows.Forms.Label
            $LabelBureau.Location = New-Object System.Drawing.Point(15, 50)
            $LabelBureau.Size = New-Object System.Drawing.Size(150, 20)
            $LabelBureau.Text = "Bureau :"
            $tabpage_newuser.Controls.Add($LabelBureau)

            $LabelBureau.Text = "Bâtiment 4"

            $LabelBureau.Text = "Bâtiment 4"
            $LabelBureauError.Text = "Entrez les 3 derniers chiffres du bureau"

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

