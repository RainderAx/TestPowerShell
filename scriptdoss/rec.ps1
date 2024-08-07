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
$tabcontrol_Cabinet = New-Object System.Windows.Forms.TabControl
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



$tabpage_newuser.AutoSize = $true
$tabpage_newuser.Location = New-Object System.Drawing.Point(4, 32)
$tabpage_newuser.Name = 'tabpage_newuser_'
$tabpage_newuser.Size = new-object System.Drawing.Size(600, 500)
$tabpage_newuser.TabIndex = 100
$tabpage_newuser.Text = 'Cabinet'
$tabcontrol_Cabinet.Controls.Add($tabpage_newuser)

Impossible d’appeler une méthode dans une expression Null.
Au caractère Ligne:3 : 1
+ $tabpage_newuser.Controls.Add($TextBoxNom)
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation : (:) [], RuntimeException
    + FullyQualifiedErrorId : InvokeMethodOnNull
 
La propriété « AutoSize » est introuvable dans cet objet. Vérifiez qu’elle existe et qu’elle peut être définie.
Au caractère Ligne:51 : 1
+ $tabpage_newuser.AutoSize = $true
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation : (:) [], RuntimeException
    + FullyQualifiedErrorId : PropertyNotFound
 
La propriété « Location » est introuvable dans cet objet. Vérifiez qu’elle existe et qu’elle peut être définie.
Au caractère Ligne:52 : 1
+ $tabpage_newuser.Location = New-Object System.Drawing.Point(4, 32)
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation : (:) [], RuntimeException
    + FullyQualifiedErrorId : PropertyNotFound
 
La propriété « Name » est introuvable dans cet objet. Vérifiez qu’elle existe et qu’elle peut être définie.
Au caractère Ligne:53 : 1
+ $tabpage_newuser.Name = 'tabpage_newuser_'
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation : (:) [], RuntimeException
    + FullyQualifiedErrorId : PropertyNotFound
 
La propriété « Size » est introuvable dans cet objet. Vérifiez qu’elle existe et qu’elle peut être définie.
Au caractère Ligne:54 : 1
+ $tabpage_newuser.Size = new-object System.Drawing.Size(600, 500)
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation : (:) [], RuntimeException
    + FullyQualifiedErrorId : PropertyNotFound
 
La propriété « TabIndex » est introuvable dans cet objet. Vérifiez qu’elle existe et qu’elle peut être définie.
Au caractère Ligne:55 : 1
+ $tabpage_newuser.TabIndex = 100
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation : (:) [], RuntimeException
    + FullyQualifiedErrorId : PropertyNotFound
 
La propriété « Text » est introuvable dans cet objet. Vérifiez qu’elle existe et qu’elle peut être définie.
Au caractère Ligne:56 : 1
+ $tabpage_newuser.Text = 'Cabinet'
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation : (:) [], RuntimeException
    + FullyQualifiedErrorId : PropertyNotFound
 
Exception lors de l'appel de « Add » avec « 1 » argument(s) : « La référence d'objet n'est pas définie à une instance d'un objet. »
Au caractère Ligne:57 : 1
+ $tabcontrol_Cabinet.Controls.Add($tabpage_newuser)
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [], MethodInvocationException
    + FullyQualifiedErrorId : NullReferenceException
 