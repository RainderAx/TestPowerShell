# Importer le module Windows Forms
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Créer la fenêtre principale
$Form = New-Object System.Windows.Forms.Form
$Form.ClientSize = '500,500' # Taille de la fenêtre
$Form.Text = "Mon UI en PS avec onglets" # Titre de la fenêtre
$Form.FormBorderStyle = 'Fixed3D'
$Form.MaximizeBox = $false

# Créer et configurer le MenuStrip
$Menu = New-Object System.Windows.Forms.MenuStrip
$Menu.Location = New-Object System.Drawing.Point(0, 0)
$Menu.ShowItemToolTips = $True

$MenuFile = New-Object System.Windows.Forms.ToolStripMenuItem
$MenuFile.Text = " &Fichier "

$MenuAbout = New-Object System.Windows.Forms.ToolStripMenuItem
$MenuAbout.Text = " &A propos "

$MenuFileQuit = New-Object System.Windows.Forms.ToolStripMenuItem
$MenuFileQuit.Text = " &Quitter "
$MenuFileQuit.ToolTipText = " Infobulle d’aide "
$MenuFileQuit.Add_Click({ $Form.Close() })

# Ajouter l'élément Quitter au menu Fichier
$MenuFile.DropDownItems.Add($MenuFileQuit)

# Ajouter les éléments Fichier et À propos au MenuStrip
$Menu.Items.AddRange(@($MenuFile, $MenuAbout))

# Ajouter le MenuStrip au formulaire
$Form.Controls.Add($Menu)

# Créer et configurer le TabControl
$TabControl = New-Object System.Windows.Forms.TabControl
$TabControl.Dock = [System.Windows.Forms.DockStyle]::Fill

# Créer les onglets
$TabPage1 = New-Object System.Windows.Forms.TabPage
$TabPage1.Text = "Onglet A"

$TabPage2 = New-Object System.Windows.Forms.TabPage
$TabPage2.Text = "Onglet B"

# Ajouter les onglets au TabControl
$TabControl.TabPages.Add($TabPage1)
$TabControl.TabPages.Add($TabPage2)

# Ajouter le TabControl au formulaire
$Form.Controls.Add($TabControl)

# Contenu de l'Onglet A
# Créer une étiquette pour le menu déroulant
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(150, 20)
$label.Text = "Choisissez un bâtiment :"
$TabPage1.Controls.Add($label)

# Créer le menu déroulant (ComboBox)
$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = New-Object System.Drawing.Point(170, 20)
$comboBox.Size = New-Object System.Drawing.Size(100, 20)
$comboBox.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList

# Ajouter des options au menu déroulant
$options = @("BAT4", "BAT5", "BAT6", "ROQUELAURE", "LEPLAY", "LESDIGUIERE")
$comboBox.Items.AddRange($options)

# Ajouter le ComboBox à l'onglet
$TabPage1.Controls.Add($comboBox)

# Créer une étiquette pour afficher les erreurs
$LabelBureauError = New-Object System.Windows.Forms.Label
$LabelBureauError.Location = New-Object System.Drawing.Point(10, 80)
$LabelBureauError.Size = New-Object System.Drawing.Size(260, 20)
$LabelBureauError.ForeColor = [System.Drawing.Color]::Red
$TabPage1.Controls.Add($LabelBureauError)

# Créer un TextBox pour le bureau et le rendre invisible par défaut
$TextBureau = New-Object System.Windows.Forms.TextBox
$TextBureau.Location = New-Object System.Drawing.Point(20, 50)
$TextBureau.Size = New-Object System.Drawing.Size(100, 30)
$TextBureau.Visible = $false
$TabPage1.Controls.Add($TextBureau)

# Créer un bouton pour valider la sélection
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(10, 110)
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Text = "Valider"
$TabPage1.Controls.Add($button)

# Créer un bouton supplémentaire pour l'onglet A
$butt = New-Object System.Windows.Forms.Button
$butt.Location = New-Object System.Drawing.Point(120, 110)
$butt.Size = New-Object System.Drawing.Size(100, 30)
$butt.Text = "Vr"
$TabPage1.Controls.Add($butt)
$butt.Add_Click({ Write-Host "grrrt baw" })

# Ajouter un bouton pour passer à l'onglet B
$buttonToTabB = New-Object System.Windows.Forms.Button
$buttonToTabB.Location = New-Object System.Drawing.Point(10, 150)
$buttonToTabB.Size = New-Object System.Drawing.Size(100, 30)
$buttonToTabB.Text = "Aller à l'onglet B"
$buttonToTabB.Add_Click({
    $TabControl.SelectedTab = $TabPage2
})
$TabPage1.Controls.Add($buttonToTabB)

# Définir la variable globale VerifBureau
[bool]$Global:VerifBureau = $false

# Ajouter un événement au bouton pour afficher la sélection
$button.Add_Click({
    $selectedOption = $comboBox.SelectedItem

    switch ($selectedOption) {
        "BAT4" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
        }
        "BAT5" { 
            $TextBureau.Visible = $false
            [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : BAT5") 
        }
        "BAT6" { 
            $TextBureau.Visible = $false
            [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : BAT6") 
        }
        "ROQUELAURE" { 
            $TextBureau.Visible = $false
            [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : ROQUELAURE") 
        }
        "LEPLAY" { 
            $TextBureau.Visible = $false
            [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : LEPLAY") 
        }
        "LESDIGUIERE" { 
            $TextBureau.Visible = $false
            [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : LESDIGUIERE") 
        }
        default { 
            $TextBureau.Visible = $false
            [System.Windows.Forms.MessageBox]::Show("Option non reconnue") 
        }
    }
})

# Ajouter un événement LostFocus au TextBox pour la validation
$TextBureau.Add_LostFocus({
    [String]$Bureau = $TextBureau.Text.Trim()

    if ($Bureau -ne $null) {
        $Global:VerifBureau = $false

        Write-Host "c est Bureau: '$Bureau'"
        Write-Host "Length: $($Bureau.Length)"

        if ($Bureau.Length -ne 3) {
            $LabelBureauError.Text = 'Le champ doit contenir 3 caractères'
        } elseif ($Bureau -notmatch '^[0-9]+$') {
            $LabelBureauError.Text = 'Le champ doit contenir uniquement des chiffres'
        } else {
            $LabelBureauError.Text = ''
            $Global:VerifBureau = $true
        }
    } else {
        $LabelBureauError.Text = 'Le champ ne peut pas être vide'
        Write-Host "TextBox est null ou TextBox.Text est null"
    }
    Write-Host "c est Bureau: '$Bureau'"
    Write-Host "Length: $($Bureau.Length)"
})

# Contenu de l'Onglet B
# Ajouter des contrôles spécifiques à l'onglet B, par exemple un message de bienvenue
$labelB = New-Object System.Windows.Forms.Label
$labelB.Location = New-Object System.Drawing.Point(10, 20)
$labelB.Size = New-Object System.Drawing.Size(200, 20)
$labelB.Text = "Bienvenue dans l'onglet B!"
$TabPage2.Controls.Add($labelB)

# Ajouter un bouton pour passer à l'onglet A
$buttonToTabA = New-Object System.Windows.Forms.Button
$buttonToTabA.Location = New-Object System.Drawing.Point(10, 50)
$buttonToTabA.Size = New-Object System.Drawing.Size(100, 30)
$buttonToTabA.Text = "Aller à l'onglet A"
$buttonToTabA.Add_Click({
    $TabControl.SelectedTab = $TabPage1
})
$TabPage2.Controls.Add($buttonToTabA)

# Afficher la fenêtre
$Form.Add_Shown({ $Form.Activate() })
[void]$Form.ShowDialog()
