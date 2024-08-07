$TextBoxNom = New-Object System.Windows.Forms.TextBox
$tabpage_newuser.Controls.Add($TextBoxNom)

#methode pour que les lettres du nom soit en majuscule
$TextBoxNom.Add_textChanged({
	$TextBoxNom.Text = ($TextBoxNom.Get_Text()).ToUpper()
	$TextBoxNom.SelectionStart = $TextBoxNom.Text.Length
	$TextBoxNom.SelectionLength = 0
})

#methode qui vérifie si le champ du nom ne contient que des lettres
$TextBoxNom.Add_LostFocus({
	if ($Global:VerifNom -eq $true) {
		return
	}
		
	$chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ '
	
	for ( $i=0; $i -lt ($TextBoxNom.text).Length; $i++ ) {
		if ($chars -match $TextBoxNom.Text[$i] -ne $true) {
			ChangeLabelError $LabelNomError 'Le champ doit contenir que des lettres'
			$Global:VerifNom = $false
			Break
		}
		else {
			$Global:VerifNom = $true
		}
	}
	if ($Global:VerifNom -eq $true) {
		ChangeLabelOK $LabelNomError
	}
})

[String]$Nom=$TextBoxNom.Get_text().Trim(' ')

$TextBoxNom.Location = New-Object System.Drawing.Point(150, 155)
$TextBoxNom.Name = 'TextBoxNom'
$TextBoxNom.Size = New-Object System.Drawing.Size(200, 20)
$TextBoxNom.TabIndex = 3
##########################Archeum
# Création de la TextBox
$TextBoxNom = New-Object System.Windows.Forms.TextBox
$tabpage_newuser.Controls.Add($TextBoxNom)

# Méthode pour que les lettres du nom soient en majuscules et pour remplacer les espaces par des tirets
$TextBoxNom.Add_textChanged({
    $TextBoxNom.Text = ($TextBoxNom.Get_Text()).ToUpper().Replace(' ', '-')
    $TextBoxNom.SelectionStart = $TextBoxNom.Text.Length
    $TextBoxNom.SelectionLength = 0

    # Ajout de Write-Host pour vérifier le changement
    Write-Host "Texte actuel: $($TextBoxNom.Text)"
})

# Méthode qui vérifie si le champ du nom ne contient que des lettres et des tirets
$TextBoxNom.Add_LostFocus({
    if ($Global:VerifNom -eq $true) {
        return
    }

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
    
    if ($Global:VerifNom -eq $true) {
        ChangeLabelOK $LabelNomError
    }
})

# Initialisation du TextBoxNom
[String]$Nom = $TextBoxNom.Get_Text().Trim(' ')

$TextBoxNom.Location = New-Object System.Drawing.Point(150, 155)
$TextBoxNom.Name = 'TextBoxNom'
$TextBoxNom.Size = New-Object System.Drawing.Size(200, 20)
$TextBoxNom.TabIndex = 3
