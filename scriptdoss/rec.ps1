# Ajouter un événement au bouton pour afficher la sélection
$button.Add_Click({
    $selectedOption = $comboBox.SelectedItem

    # Mettre à jour l'étiquette LabelBureau en fonction de l'option choisie
    
    $LabelBureau.Visible = $true

    # switchcase pour afficher les batiments 
    switch ($selectedOption) {
        "BAT4" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '4'
            $LabelBureau.Text = "Batiment 4 :"
            $LabelBureau.Visible = $true
        }
        "BAT5" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '5'
            $LabelBureau.Text = "Batiment 5 :"
            $LabelBureau.Visible = $true
        }
        "BAT6" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '6'
            $LabelBureau.Text = "Batiment 6 :"
            $LabelBureau.Visible = $true
        }
        "ROQUELAURE" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = 'ROQ'
            $LabelBureau.Text = "Roquelaure :"
            $LabelBureau.Visible = $true
        }
        "LEPLAY" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '7'
            $LabelBureau.Text = "Leplay :"
            $LabelBureau.Visible = $true
        }
        "LESDIGUIERE" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = 'LES'
            $LabelBureau.Text = "Lesdiguiere :"
            $LabelBureau.Visible = $true 
        }
        "Saisie Manuelle" {
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

    # Vérifie si le champ est vide
    if ($Global:Bureau -ne $null) {
        $Global:VerifBureau = $false

        #### test sur la console
        Write-Host "c est Bureau: '$Global:Bureau'"
        Write-Host "Length: $($Global:Bureau.Length)"
        ####

        # Si l'option sélectionnée est "Saisie Manuelle", ignorer les vérifications
        if ($selectedOption -eq "Saisie Manuelle") {
            $LabelBureauError.Text = ''
            $Global:VerifBureau = $true
            Write-Host "Saisie Manuelle sélectionnée, aucune vérification appliquée"
        }
        else {
            # Vérifie si la longueur du texte est de 3 caractères
            if ($Global:Bureau.Length -ne 3) {
                $LabelBureauError.Text = 'Le champ doit contenir 3 caractères'
                Write-Host "Le champ doit contenir 3 caractères"
            } elseif ($Global:Bureau -notmatch '^[0-9]+$') {
                # Vérifie si le texte contient uniquement des chiffres
                $LabelBureauError.Text = 'Le champ doit contenir uniquement des chiffres'
                Write-Host "Le champ doit contenir uniquement des chiffres"
            } else {
                # Si toutes les conditions sont remplies
                $LabelBureauError.Text = ''
                $Global:VerifBureau = $true
                $Global:bur = "$Global:choice" + "$Global:Bureau"
                Write-Host "Toutes les conditions sont remplies"
            }
        }
    } elseif ($comboBox.SelectedItem -eq "Saisie Manuelle") {
        $Global:VerifBureau = $true
        Write-Host "Saisie Manuelle sélectionnée, aucune vérification appliquée"
    } else {
        $LabelBureauError.Text = 'Le champ ne peut pas être vide'
        #### test sur la console
        Write-Host "TextBox est null ou TextBox.Text est null"
        ####
    }
    #### test sur la console
    Write-Host "c est Bureau: '$Global:Bureau'"
    Write-Host "Length: $($Global:Bureau.Length)"
    Write-Host "$Global:bur"
    Write-Host "Verification: $Global:VerifBureau"
})
