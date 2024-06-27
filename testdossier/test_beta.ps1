# Importer le module Windows Forms et Active Directory
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Import-Module ActiveDirectory

# Créer une nouvelle forme
$form = New-Object System.Windows.Forms.Form
$form.Text = "Modifier les Propriétés d'un Utilisateur AD"
$form.Size = New-Object System.Drawing.Size(300, 300)
$form.StartPosition = "CenterScreen"

# Ajouter les contrôles
$labelSamAccountName = New-Object System.Windows.Forms.Label
$labelSamAccountName.Text = "SamAccountName:"
$labelSamAccountName.Location = New-Object System.Drawing.Point(10, 20)
$form.Controls.Add($labelSamAccountName)

$textBoxSamAccountName = New-Object System.Windows.Forms.TextBox
$textBoxSamAccountName.Location = New-Object System.Drawing.Point(140, 20)
$form.Controls.Add($textBoxSamAccountName)

$labelOfficeNumber = New-Object System.Windows.Forms.Label
$labelOfficeNumber.Text = "Numéro de Bureau:"
$labelOfficeNumber.Location = New-Object System.Drawing.Point(10, 60)
$form.Controls.Add($labelOfficeNumber)

$textBoxOfficeNumber = New-Object System.Windows.Forms.TextBox
$textBoxOfficeNumber.Location = New-Object System.Drawing.Point(140, 60)
$form.Controls.Add($textBoxOfficeNumber)

$button = New-Object System.Windows.Forms.Button
$button.Text = "Mettre à jour"
$button.Location = New-Object System.Drawing.Point(100, 100)
$button.Add_Click({
    $samAccountName = $textBoxSamAccountName.Text
    $officeNumber = $textBoxOfficeNumber.Text

    # Mettre à jour les propriétés de l'utilisateur AD
    try {
        Set-ADUser -Identity $samAccountName -Office $officeNumber
        [System.Windows.Forms.MessageBox]::Show("Propriétés de l'utilisateur mises à jour avec succès!")
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Erreur: $_")
    }
})
$form.Controls.Add($button)

# Afficher la forme
$form.ShowDialog()
