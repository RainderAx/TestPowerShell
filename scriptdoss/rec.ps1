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
$label.Text = "Choisissez un bâtiment :"
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

# Créer une étiquette pour afficher les erreurs
$LabelBureauError = New-Object System.Windows.Forms.Label
$LabelBureauError.Location = New-Object System.Drawing.Point(10, 80)
$LabelBureauError.Size = New-Object System.Drawing.Size(260, 20)
$LabelBureauError.ForeColor = [System.Drawing.Color]::Red
$form.Controls.Add($LabelBureauError)

# Créer un TextBox pour le bureau et le rendre invisible par défaut
$TextBureau = New-Object System.Windows.Forms.TextBox
$TextBureau.Location = New-Object System.Drawing.Point(20, 50)
$TextBureau.Size = New-Object System.Drawing.Size(100, 30)
$TextBureau.Visible = $false
$form.Controls.Add($TextBureau)

# Créer un bouton pour valider la sélection
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(10, 110)
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Text = "Valider"
$form.Controls.Add($button)

# Créer un bouton pour une action supplémentaire
$butt = New-Object System.Windows.Forms.Button
$butt.Location = New-Object System.Drawing.Point(120, 110)
$butt.Size = New-Object System.Drawing.Size(100, 30)
$butt.Text = "Vr"
$form.Controls.Add($butt)

# Déclarer une variable globale pour stocker la valeur de Bureau
$Global:Bureau = ""

# Ajouter un événement au bouton pour afficher la sélection
$button.Add_Click({
    $selectedOption = $comboBox.SelectedItem

    switch ($selectedOption) {
        "BAT4" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
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
        }
    } else {
        $LabelBureauError.Text = 'Le champ ne peut pas être vide'
        Write-Host "TextBox est null ou TextBox.Text est null"
    }
    Write-Host "c est Bureau: '$Global:Bureau'"
    Write-Host "Length: $($Global:Bureau.Length)"
})

# Ajouter un événement au bouton "Vr"
$butt.Add_Click({
    if ($Global:VerifBureau) {
        try {
            $users = Get-ADUser -Filter "samAccountName -like '$Global:Bureau*'"
            [System.Windows.Forms.MessageBox]::Show("Utilisateurs trouvés : $($users.Count)")
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Erreur : $_")
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Le champ de bureau n'est pas valide")
    }
})

# Afficher la fenêtre
$form.ShowDialog()


$tesr = "alexis"

# Ajouter un événement Click au bouton $butt pour utiliser la valeur de Bureau
$butt.Add_Click({
    Write-Host "grrrt baw"
    $blablou = Get-ADUser -Filter "samAccountName -like '$Global:Bureau*' + '$tesr*' "
    Write-Host "$blablou"
})

# Afficher la fenêtre
$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()
