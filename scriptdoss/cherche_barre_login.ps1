#Charge en mÃ©moire les Ã©lÃ©ments graphiques necessaires
[void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
$Form10 = New-object System.Windows.Forms.form
$TextBoxPrenom = New-Object System.Windows.Forms.TextBox
$TextBoxNom = New-Object System.Windows.Forms.TextBox
$TextTelephone = New-Object System.Windows.Forms.TextBox
$TextBureau = New-Object System.Windows.Forms.TextBox

$LabelPrenom = New-Object System.Windows.Forms.Label
$LabelPrenomError = New-Object System.Windows.Forms.Label
$LabelNom = New-Object System.Windows.Forms.Label
$LabelNomError = New-Object System.Windows.Forms.Label
$LabelTelephone = New-Object System.Windows.Forms.Label
$LabelTelephoneError = New-Object System.Windows.Forms.Label

$labelBureau = New-Object System.Windows.Forms.Label
$labelBureauError = New-Object System.Windows.Forms.Label
$Labelservice = New-Object System.Windows.Forms.Label
$labelMessage = New-Object System.Windows.Forms.Label
$ComboBoxService = New-Object System.Windows.Forms.ComboBox
$ComboBoxPoste = New-Object System.Windows.Forms.ComboBox

#ajout
$TextBoxLogin = New-Object System.Windows.Forms.TextBox
$LabelLogin = New-Object System.Windows.Forms.Label


$tabcontrol_Cabinet = New-Object System.Windows.Forms.TabControl
$tabpage_newuser = New-Object System.Windows.Forms.TabPage

#ajout
$tabpage_newuser.Controls.Add($LabelLOGIN)

$tabpage_newuser.Controls.Add($LabelNom)
$tabpage_newuser.Controls.Add($LabelNomError)
$tabpage_newuser.Controls.Add($LabelPrenom)
$tabpage_newuser.Controls.Add($LabelPrenomError)
$tabpage_newuser.Controls.Add($LabelTelephone)
$tabpage_newuser.Controls.Add($LabelTelephoneError)

$tabpage_newuser.Controls.Add($labelBureau)
$tabpage_newuser.Controls.Add($labelBureauerror)
$tabpage_newuser.Controls.Add($Labelservice)
$tabpage_newuser.Controls.Add($LabelMessage)

$tabpage_newuser.Controls.Add($TextTelephone)
$tabpage_newuser.Controls.Add($TextBoxPrenom)
$tabpage_newuser.Controls.Add($TextBoxNom)

$tabpage_newuser.Controls.Add($textBureau)
$tabpage_newuser.Controls.Add($ComboBoxService)


#Valeurs qui permettent de vÃ©rifier les valeurs des champs necessaires pour crÃ©er un utilisateur
[bool]$Global:VerifPrenom=$false
[bool]$Global:VerifNom=$false
[bool]$Global:VerifBureau=$false
[bool]$Global:VerifTelephone=$false

#ajout
[bool]$Global:VerifLogin=$false
###

#Chargement parametre domaine 
[string]$settingsFile = "PwdCabinet.xml" 



$TextBoxNom.Add_textChanged({
	$TextBoxNom.Text = ($TextBoxNom.Get_Text()).ToUpper()
	$TextBoxNom.SelectionStart = $TextBoxNom.Text.Length
	$TextBoxNom.SelectionLength = 0
})

$TextBoxPrenom.Add_textChanged({
	$TextBoxPrenom.Text = (Get-Culture).textinfo.totitlecase($TextBoxPrenom.Text.Split(' '))
	$TextBoxPrenom.SelectionStart = $TextBoxPrenom.Text.Length
	$TextBoxPrenom.SelectionLength = 0
})

$TextTelephone.Add_LostFocus({
	if ($TextTelephone.Text.Length -eq 0) {
		ChangeLabelOk $LabelTelephoneError
		$Global:VerifTelephone=$false
		return
	}
	
	elseif ($TextTelephone.Text.Length -ne 5) {
		ChangeLabelError $LabelTelephoneError 'Merci de mettre que les 5 derniers numeros'
		$Global:VerifTelephone=$false
		return
	}
	
	Try {
	[Int]$TestTelephone=$TextTelephone.Text
	}	
	
	Catch [System.Management.Automation.PSInvalidCastException] {
		$Global:VerifTelephone=$false
		ChangeLabelError $LabelTelephoneError 'Le champ doit contenir que des chiffres'
		return
	}
	$Global:VerifTelephone=$true
	ChangeLabelOk $LabelTelephoneError
})

#ajout 
$TextBoxLogin.Add_LostFocus({
	
	if ($Global:VerifLogin -eq $true) {
		return
	}
	
		$Global:VerifPrenom = $true
})



#AJOUT
$TextBoxLogin.Add_textChanged({
	$TextBoxLogin.Text = ($TextBoxNom.Get_Text())
	$TextBoxLogin.SelectionStart = $TextBoxLogin.Text.Length
	$TextBoxLogin.SelectionLength = 0
})



$TextBoxPrenom.Add_LostFocus({
	
	if ($Global:VerifPrenom -eq $true) {
		return
	}
	
	$chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ '
	
	for ( $i=0; $i -lt ($TextBoxPrenom.text).Length; $i++ ) {
		if ($chars -match $TextBoxPrenom.Text[$i] -ne $true) {
			ChangeLabelError $LabelPrenomError 'Le champ doit contenir que des lettres'
			$Global:VerifPrenom = $false
			Break
		}
		else {
			$Global:VerifPrenom = $true
		}
	}
	if ($Global:VerifPrenom -eq $true) {
		ChangeLabelOK $LabelPrenomError 
	}
})

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

$TextBureau.Add_LostFocus({
	$chars = '0123456789'
	
	for ( $i=0; $i -lt ($TextBureau.text).Length; $i++ ) {
		if ($chars -match $TextBureau.Text[$i] -ne $true) {
			ChangeLabelError $LabelBureauError 'Le champ doit contenir que des chiffres'
			$Global:VerifBureau = $false
			Break
		}
		
		elseif ($TextBureau.Text.Length -ne 4) {
			ChangeLabelError $LabelBureauError 'Le champ doit contenir 4 caractÃ¨res'
			return
		}
		else {
			ChangeLabelOK $LabelBureauError
			$Global:VerifBureau = $true
		}
	}
})


#Fonction qui permet de prendre les initials de plusieurs prÃ©noms
function MultiPrenom{
	Param($Prenom=$args[0])
	
	for( $i=0; $i -lt ($Prenom.Split(' ')).Count; $i++ )
      {
         $MultiPrenom+=$Prenom.Split(' ')[$i][0]
      }
	return $MultiPrenom
}

#Fonction qui permet de prendre l' initial d'un prenom
function InitialPrenom{
	Param($Prenom=$args[0])
	
	if (($Prenom.Split(' ')).Count -eq 1) {
		return $Prenom[0]
	}
	elseif (($Prenom.Split(' ')).Count -ge 2)
	{
		$InitialPrenom = MultiPrenom $Prenom
		return $InitialPrenom
	}

}

#Fonction pour l'affichage des messages d'erreurs
Function ChangeLabelError{
	Param($LabelError=$args[0], $TextError=$args[1])
	
	$LabelError.Forecolor = 'Red'
	$LabelError.text = $TextError
}

#Fonction pour l'affichage des messages d'informations
Function ChangeLabelOk{
	Param($LabelError=$args[0])
	
	$LabelError.Forecolor = 'Green'
	$LabelError.text = 'OK'
}

#Fonction qui gÃ©nÃ¨re un mot de passe alÃ©atoire
function Generate-Pwd {
	Param([bool]$chiffres=$args[0], [bool]$minuscules=$args[1], [bool]$majuscules=$args[2], [bool]$autres=$args[3], [int]$len=$args[4])
	[string]$chars = ''
   
   if ($chiffres -eq 1) {$chars += '0123456789';$complex += 1}
   if ($majuscules -eq 1) {$chars += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';$complex += 1}
   if ($minuscules -eq 1) {$chars += 'abcdefghijklmnopqrstuvwxyz';$complex += 1}
   if ($autres -eq 1) {$chars += '_!@#$%';$complex += 1}

   if($chars -ne ''){
      $bytes = new-object 'System.Byte[]' $len
      $rnd = new-object System.Security.Cryptography.RNGCryptoServiceProvider
      $rnd.GetBytes($bytes)
      $result = ''
      for( $i=0; $i -lt $len; $i++ )
      {
         $result += $chars[ $bytes[$i] % $chars.Length ]
      }
     return $result
	  }
}




# LabelPrenom
#
$LabelPrenom.AutoSize = $true
$LabelPrenom.Location = New-Object System.Drawing.Point(15, 75)
$LabelPrenom.Name = 'LabelPrenom'
$LabelPrenom.Size = New-Object System.Drawing.Size(129, 15)
$LabelPrenom.Text = 'Prenom'
#
# LabelPrenomError
#
$LabelPrenomError.AutoSize = $true
$LabelPrenomError.Location = New-Object System.Drawing.Point(375, 75)
$LabelPrenomError.Name = 'LabelPrenomError'
$LabelPrenomError.Size = New-Object System.Drawing.Size(129, 15)
$LabelPrenomError.Text = ''
#
# LabelNom
#
$LabelNom.AutoSize = $true
$LabelNom.Location = New-Object System.Drawing.Point(15, 125)
$LabelNom.Name = 'LabelNom'
$LabelNom.Size = New-Object System.Drawing.Size(71, 13)
$LabelNom.Text = 'Nom'
#
# LabelNomError
#
$LabelNomError.AutoSize = $true
$LabelNomError.Location = New-Object System.Drawing.Point(375, 125)
$LabelNomError.Name = 'LabelNomError'
$LabelNomError.Size = New-Object System.Drawing.Size(71, 13)
#
# LabelTelephone
#
$LabelTelephone.AutoSize = $true
$LabelTelephone.Location = New-Object System.Drawing.Point(15, 225)
$LabelTelephone.Name = 'LabelTelephone'
$LabelTelephone.Size = New-Object System.Drawing.Size(71, 13)
$LabelTelephone.Text = 'Telephone (optionel)'
#

# LabelTelephoneError
#
$LabelTelephoneError.AutoSize = $true
$LabelTelephoneError.Location = New-Object System.Drawing.Point(260, 225)
$LabelTelephoneError.Name = 'LabelTelephoneError'
$LabelTelephoneError.Size = New-Object System.Drawing.Size(71, 13)
$LabelTelephoneError.Text = ''
#
# LabelBureau
#
$LabelBureau.AutoSize = $true
$LabelBureau.Location = New-Object System.Drawing.Point(15, 25)
$LabelBureau.Name = 'LabelBureau'
$LabelBureau.Size = New-Object System.Drawing.Size(71, 13)
$LabelBureau.Text = 'Bureau'
#
# LabelBureauerror
#
$LabelBureauerror.AutoSize = $true
$LabelBureauerror.Location = New-Object System.Drawing.Point(375, 25)
$LabelBureauerror.Name = 'LabelBureauerror'
$LabelBureauerror.Size = New-Object System.Drawing.Size(71, 13)
$LabelBureauerror.Text = ''
#
# Labelservice
#
$Labelservice.AutoSize = $true
$Labelservice.Location = New-Object System.Drawing.Point(15, 175)
$Labelservice.Name = 'Labelservice'
$Labelservice.Size = New-Object System.Drawing.Size(71, 13)
$Labelservice.Text = 'Service'
#
# LabelMessage
#
$LabelMessage.AutoSize = $true
$LabelMessage.Location = New-Object System.Drawing.Point(200, 415)
$LabelMessage.Name = 'LabelMessage'
$LabelMessage.Text = ''
#
# TextBureau
#
$TextBureau.Location = New-Object System.Drawing.Point(150, 25)
$TextBureau.MaxLength = 20
$TextBureau.Name = 'TextBureau'
$TextBureau.Size = New-Object System.Drawing.Size(200, 20)
$TextBureau.TabIndex = 1
#
# TextBoxPrenom
#
$TextBoxPrenom.Location = New-Object System.Drawing.Point(150, 75)
$TextBoxPrenom.Name = 'TextBoxPrenom'
$TextBoxPrenom.Size = New-Object System.Drawing.Size(200, 20)
$TextBoxPrenom.TabIndex = 2
#
# TextBoxNom
#
$TextBoxNom.Location = New-Object System.Drawing.Point(150, 125)
$TextBoxNom.Name = 'TextBoxNom'
$TextBoxNom.Size = New-Object System.Drawing.Size(200, 20)
$TextBoxNom.TabIndex = 3
#
# TextTelephone
#
$TextTelephone.Location = New-Object System.Drawing.Point(150, 225)
$TextTelephone.MaxLength = 7
$TextTelephone.Name = 'TextTelephone'
$TextTelephone.Size = New-Object System.Drawing.Size(100, 20)
$TextTelephone.TabIndex = 5
#
# ComboBoxPoste
#
$ComboBoxPoste.Location = New-Object System.Drawing.Point(150, 275)
$ComboBoxPoste.Name = 'ComboBoxPoste'
$ComboBoxPoste.Size = New-Object System.Drawing.Size(200, 20)
$ComboBoxPoste.TabIndex = 6
$ComboBoxPoste.DropDownStyle='DropDownList'

#
# ComboBoxService
#
$ComboBoxService.Location = New-Object System.Drawing.Point(150, 175)
$ComboBoxService.Name = 'ComboBoxService'
$ComboBoxService.Size = New-Object System.Drawing.Size(200, 20)
$ComboBoxService.DropDownStyle='DropDownList'
$ComboBoxService.TabIndex = 4
#
# tabpage_newuser
#
$tabpage_newuser.AutoSize = $true
$tabpage_newuser.Location = New-Object System.Drawing.Point(4, 22)
$tabpage_newuser.Name = 'tabpage_newuser_'
$tabpage_newuser.Size = new-object System.Drawing.Size(600, 500)
$tabpage_newuser.TabIndex = 100
$tabpage_newuser.Text = 'Cabinet'
#
# tabcontrol_Cabinet
#
$tabcontrol_Cabinet.AutoSize = $true
$tabcontrol_Cabinet.Location = New-Object System.Drawing.Point(0, 0)
$tabcontrol_Cabinet.Name = 'tabcontrol_User'
$tabcontrol_Cabinet.Size = new-object System.Drawing.Size(600, 500)
$tabcontrol_Cabinet.TabIndex = 99
$tabcontrol_Cabinet.Text = 'Droit'
$tabcontrol_Cabinet.Controls.Add($tabpage_newuser)

#ajout
#
# LabelLogin
#
$LabelLogin.AutoSize = $true
$LabelLogin.Location = New-Object System.Drawing.Point(15, 275)
$LabelLogin.Name = 'LabelLogin'
$LabelLogin.Size = New-Object System.Drawing.Size(71, 13)
$LabelLogin.Text = 'Login'

#
# TextBoxLogin
#
$TextBoxLogin.Location = New-Object System.Drawing.Point(150, 220)
$TextBoxLogin.Name = 'TextBoxLogin'
$TextBoxLogin.Size = New-Object System.Drawing.Size(200, 20)
$TextBoxLogin.TabIndex = 3
####



#
# Form1
#
$Form10.ClientSize = New-Object System.Drawing.Size(600, 500)
$Form10.MaximumSize = New-Object System.Drawing.Size(600, 500)
$Form10.MinimumSize = New-Object System.Drawing.Size(600, 500)
$Form10.Controls.Add($tabcontrol_Cabinet)

$Form10.Name = 'Form1'
$Form10.Text = 'Createur Utilisateur Cabinet'
$Form10.ShowDialog()
