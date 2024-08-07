# Import necessary .NET namespaces
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the TabPage and TabControl
$tabpage_newuser = New-Object System.Windows.Forms.TabPage
$tabcontrol_Cabinet = New-Object System.Windows.Forms.TabControl

# Initialize the TextBox
$TextBoxNom = New-Object System.Windows.Forms.TextBox
$tabpage_newuser.Controls.Add($TextBoxNom)

# Method to convert the text to uppercase and replace spaces with dashes
$TextBoxNom.Add_TextChanged({
    $TextBoxNom.Text = ($TextBoxNom.Text).ToUpper().Replace(' ', '-')
    $TextBoxNom.SelectionStart = $TextBoxNom.Text.Length
    $TextBoxNom.SelectionLength = 0

    # Debugging output
    Write-Host "Texte actuel: $($TextBoxNom.Text)"
})

# Method to verify the text contains only letters and dashes
$TextBoxNom.Add_LostFocus({
    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-'

    for ($i = 0; $i -lt ($TextBoxNom.Text).Length; $i++) {
        if ($chars -notcontains $TextBoxNom.Text[$i]) {
            ChangeLabelError $LabelNomError 'Le champ doit contenir que des lettres et des tirets'
            $Global:VerifNom = $false
            break
        } else {
            $Global:VerifNom = $true
        }
    }

    if ($Global:VerifNom) {
        ChangeLabelOK $LabelNomError
    }
})

# Initial settings for the TextBox
$TextBoxNom.Location = New-Object System.Drawing.Point(150, 155)
$TextBoxNom.Name = 'TextBoxNom'
$TextBoxNom.Size = New-Object System.Drawing.Size(200, 20)
$TextBoxNom.TabIndex = 3

# Initial settings for the TabPage
$tabpage_newuser.AutoSize = $true
$tabpage_newuser.Location = New-Object System.Drawing.Point(4, 32)
$tabpage_newuser.Name = 'tabpage_newuser_'
$tabpage_newuser.Size = New-Object System.Drawing.Size(600, 500)
$tabpage_newuser.TabIndex = 100
$tabpage_newuser.Text = 'Cabinet'

# Add the TabPage to the TabControl
$tabcontrol_Cabinet.Controls.Add($tabpage_newuser)

# Display the form for debugging
$form = New-Object System.Windows.Forms.Form
$form.Controls.Add($tabcontrol_Cabinet)
$form.ShowDialog()
