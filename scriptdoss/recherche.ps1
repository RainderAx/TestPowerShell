# Importer le module Windows Forms
Add-Type -AssemblyName System.Windows.Forms

# Créer la fenêtre
$form = New-Object System.Windows.Forms.Form
$form.Text = "Exemple de Menu Déroulant"
$form.Size = New-Object System.Drawing.Size(300, 200)

# Créer une étiquette pour le menu déroulant
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(100, 20)
$label.Text = "Choisissez une option :"
$form.Controls.Add($label)

# Créer le menu déroulant (ComboBox)
$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = New-Object System.Drawing.Point(120, 20)
$comboBox.Size = New-Object System.Drawing.Size(150, 20)

# Ajouter des options au menu déroulant
$options = @("Option 1", "Option 2", "Option 3", "Option 4")
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
    [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : $selectedOption")
})

# Afficher la fenêtre
$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()
