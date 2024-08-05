#ce script permet de renseigner le champs de desciption de l'ordinateur 

#22/02/23 (modif faite par Ali)
# la maj un email de notification

#16/03/23 (modif faite par Ali)
# ce script génère un fichier txt qui va être traité par un autre script en tâche planifier

#26/07/24 (modif faite par Alexis)

#Charge en mémoire les éléments graphiques necessaires
[void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
$Form10 = new-object System.Windows.Forms.form

#
$TextBoxPrenom = New-Object System.Windows.Forms.TextBox
$TextBoxNom = New-Object System.Windows.Forms.TextBox
$TextTelephone = New-Object System.Windows.Forms.TextBox
$button_generer = New-Object System.Windows.Forms.Button
$button_quitter = New-Object System.Windows.Forms.Button
$LabelPrenom = New-Object System.Windows.Forms.Label
$LabelPrenomError = New-Object System.Windows.Forms.Label
$LabelNom = New-Object System.Windows.Forms.Label
$LabelNomError = New-Object System.Windows.Forms.Label
$LabelTelephone = New-Object System.Windows.Forms.Label
$LabelTelephoneError = New-Object System.Windows.Forms.Label
$LabelPoste = New-Object System.Windows.Forms.Label
$Labelservice = New-Object System.Windows.Forms.Label
$labelMessage = New-Object System.Windows.Forms.Label
$ComboBoxService = New-Object System.Windows.Forms.ComboBox
$ComboBoxPoste = New-Object System.Windows.Forms.ComboBox


$tabcontrol_Cabinet = New-Object System.Windows.Forms.TabControl
$tabpage_newuser = New-Object System.Windows.Forms.TabPage

$tabpage_newuser.Controls.Add($LabelNom)
$tabpage_newuser.Controls.Add($LabelNomError)
$tabpage_newuser.Controls.Add($LabelPrenom)
$tabpage_newuser.Controls.Add($LabelPrenomError)
$tabpage_newuser.Controls.Add($LabelTelephone)
$tabpage_newuser.Controls.Add($LabelTelephoneError)
$tabpage_newuser.Controls.Add($LabelPoste)
$tabpage_newuser.Controls.Add($Labelservice)
$tabpage_newuser.Controls.Add($LabelMessage)
$tabpage_newuser.Controls.Add($button_quitter)
$tabpage_newuser.Controls.Add($button_generer)
$tabpage_newuser.Controls.Add($TextTelephone)
$tabpage_newuser.Controls.Add($TextBoxPrenom)
$tabpage_newuser.Controls.Add($TextBoxNom)
$tabpage_newuser.Controls.Add($ComboBoxPoste)
$tabpage_newuser.Controls.Add($ComboBoxService)


#Valeurs qui permettent de vérifier les valeurs des champs necessaires pour créer un utilisateur
[bool]$Global:VerifPrenom=$false
[bool]$Global:VerifNom=$false
[bool]$Global:VerifTelephone=$false

#Chargement parametre domaine 
[string]$settingsFile = "PwdCabinet.xml" 
[xml]$config = Get-Content $settingsFile


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
			ChangeLabelError $LabelBureauError 'Le champ doit contenir 4 caractères'
			return
		}
		else {
			ChangeLabelOK $LabelBureauError
			$Global:VerifBureau = $true
		}
	}
})


#Fonction qui permet de prendre les initials de plusieurs prénoms
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

#Fonction qui génère un mot de passe aléatoire
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


Function Get-InfoDomaine {
	Param($strCategory=$args[0], $DirectoryEntry=$args[1], $Element=$arg[2], $Scope=$arg[3])
	$objDomain = New-Object System.DirectoryServices.DirectoryEntry($DirectoryEntry)
	$objSearcher = New-Object System.DirectoryServices.DirectorySearcher($objDomain,"(objectCategory=$strCategory)",@('name'))
	
	if ($Element -eq 'Name') {
		if ($Scope -ne $null) {
			$objSearcher.SearchScope = $Scope
		}	
		$Clients=$objSearcher.FindAll() | %{$_.properties.name} 
	}
	elseif ($Element -eq 'adspath') {
		$Clients=$objSearcher.FindAll() | %{$_.properties.adspath} 
	}
	Return $Clients
}

############# ajout

# Créer une étiquette pour le menu déroulant
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(150, 20)
$label.Text = "Choisissez un bâtiment :"
$tabpage_newuser.Controls.Add($label)

$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = New-Object System.Drawing.Point(170, 20)
$comboBox.Size = New-Object System.Drawing.Size(100, 20)
$comboBox.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList

$options = @("BAT4", "BAT5", "BAT6", "ROQUELAURE", "LEPLAY", "LESDIGUIERE","Autre")
$comboBox.Items.AddRange($options)

$tabpage_newuser.Controls.Add($comboBox)

$LabelBureauError = New-Object System.Windows.Forms.Label
$LabelBureauError.Location = New-Object System.Drawing.Point(340, 65)
$LabelBureauError.Size = New-Object System.Drawing.Size(250, 20)
$LabelBureauError.ForeColor = [System.Drawing.Color]::Red
$tabpage_newuser.Controls.Add($LabelBureauError)


$TextBureau = New-Object System.Windows.Forms.TextBox
$TextBureau.Location = New-Object System.Drawing.Point(150, 65)
$TextBureau.Size = New-Object System.Drawing.Size(45, 30)
$TextBureau.Visible = $false
$tabpage_newuser.Controls.Add($TextBureau)

$LabelBureau = New-Object System.Windows.Forms.Label
$LabelBureau.Location = New-Object System.Drawing.Point(15, 65)
$LabelBureau.Size = New-Object System.Drawing.Size(80, 20)

$LabelBureau.Visible = $false
$tabpage_newuser.Controls.Add($LabelBureau)

$TextBureau_2 = New-Object System.Windows.Forms.TextBox
$TextBureau_2.Location = New-Object System.Drawing.Point(270, 65)
$TextBureau_2.Size = New-Object System.Drawing.Size(45, 30)
$TextBureau_2.Visible = $false
$tabpage_newuser.Controls.Add($TextBureau_2)

$LabelBureau_2 = New-Object System.Windows.Forms.Label
$LabelBureau_2.Location = New-Object System.Drawing.Point(110, 65)
$LabelBureau_2.Size = New-Object System.Drawing.Size(100, 20)
$LabelBureau_2.Text = "étage :"

$LabelBureau_2.Visible = $false
$tabpage_newuser.Controls.Add($LabelBureau_2)

$LabelBureau_3 = New-Object System.Windows.Forms.Label
$LabelBureau_3.Location = New-Object System.Drawing.Point(212, 65)
$LabelBureau_3.Size = New-Object System.Drawing.Size(100, 20)
$LabelBureau_3.Text = "N° Bureau:"

$LabelBureau_3.Visible = $false
$tabpage_newuser.Controls.Add($LabelBureau_3)

$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(300, 20)
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Text = "Valider"
$tabpage_newuser.Controls.Add($button)

$Global:Bureau = ""
$Global:choice =""
$Global:Bureau_2 = ""

$button.Add_Click({
    $selectedOption = $comboBox.SelectedItem    
    $LabelBureau.Visible = $true

    # switchcase pour afficher les batiments 
    switch ($selectedOption) {
        "BAT4" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '4'
            $LabelBureau.Text = "Batiment 4 :"
            $LabelBureau.Visible = $true

            $TextBureau_2.Visible = $true
            $TextBureau_2.Focus()

            $LabelBureau_2.Visible = $true

            $LabelBureau_3.Visible = $true
        }
        "BAT5" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '5'
            $LabelBureau.Text = "Batiment 5 :"
            $LabelBureau.Visible = $true

            $TextBureau_2.Visible = $true
            $TextBureau_2.Focus()

            $LabelBureau_2.Visible = $true

            $LabelBureau_3.Visible = $true
        }
        "BAT6" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '6'
            $LabelBureau.Text = "Batiment 6 :"
            $LabelBureau.Visible = $true

            $TextBureau_2.Visible = $true
            $TextBureau_2.Focus()

            $LabelBureau_2.Visible = $true

            $LabelBureau_3.Visible = $true
        }
        "ROQUELAURE" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = 'ROQ'
            $LabelBureau.Text = "Roquelaure :"
            $LabelBureau.Visible = $true

            $TextBureau_2.Visible = $true
            $TextBureau_2.Focus()

            $LabelBureau_2.Visible = $true

            $LabelBureau_3.Visible = $true
        }
        "LEPLAY" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = '7'
            $LabelBureau.Text = "Leplay :"
            $LabelBureau.Visible = $true

            $TextBureau_2.Visible = $true
            $TextBureau_2.Focus()

            $LabelBureau_2.Visible = $true

            $LabelBureau_3.Visible = $true
        }
        "LESDIGUIERE" {
            $TextBureau.Visible = $true
            $TextBureau.Focus()
            $Global:choice = 'LES'
            $LabelBureau.Text = "Lesdiguiere :"
            $LabelBureau.Visible = $true 

            $TextBureau_2.Visible = $true
            $TextBureau_2.Focus()

            $LabelBureau_2.Visible = $true

            $LabelBureau_3.Visible = $true
        }
        "Autre" {
            $TextBureau.Size = New-Object System.Drawing.Size(205, 30)
            $LabelBureau.Size = New-Object System.Drawing.Size(100, 20)

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

    if ($Global:Bureau -ne $null) {
        $Global:VerifBureau = $false

        #### test console
        Write-Host "c est Bureau: '$Global:Bureau'"
        Write-Host "Length: $($Global:Bureau.Length)"
        ####

        # Ignore les conditions si "Saisie Manuelle"
        if ($selectedOption -eq "Autre") {
            $LabelBureauError.Text = ''
            $Global:VerifBureau = $true
        }
	
        else {
            # Vérifie les conditions 
            if ($Global:Bureau.Length -ne 1) {
                $LabelBureauError.Text = "Le premier champ ne doit contenir qu'1 chiffre"
            } elseif ($Global:Bureau -notmatch '^[0-9]+$') {
                $LabelBureauError.Text = "Le premier champ ne doit contenir qu'1 chiffre"
            } else {
                $LabelBureauError.Text = ''
                $Global:VerifBureau = $true
                $Global:bur = "$Global:choice" + "$Global:Bureau"
            }
        }
    } elseif ($comboBox.SelectedItem -eq "Saisie Manuelle") {
        $Global:VerifBureau = $true
        $Global:bur = "$Global:choice" + "$Global:Bureau"
    } else {
        $LabelBureauError.Text = 'Le champ ne peut pas être vide'
        #### test console
        Write-Host "TextBox est null ou TextBox.Text est null"
        ####
    }
    $Global:bur = "$Global:choice" + "$Global:Bureau"
    
    #### test  console
    Write-Host "c est Bureau: '$Global:Bureau'"
    Write-Host "Length: $($Global:Bureau.Length)"
    Write-Host "$Global:bur"
    Write-Host "Verification: $Global:VerifBureau"
    #######
    
        
})

$TextBureau_2.Add_LostFocus({
    
    $PrintBur = New-Object System.Windows.Forms.Label
    $PrintBur.Location = New-Object System.Drawing.Point(320, 65)
    $PrintBur.Size = New-Object System.Drawing.Size(100, 20)
    $PrintBur.Text = "$Global:bur2"
    $Global:burtest = "$Global:bur" + "$Global:bur2"

    $PrintBur.Visible = $false
    $tabpage_newuser.Controls.Add($PrintBur)

    $Global:Bureau_2 = $TextBureau_2.Text.Trim()
    $selectedOption = $comboBox.SelectedItem
    $Global:bur2 = "$Global:bur" + "$Global:Bureau_2"
    if ($Global:Bureau_2 -ne $null) {
        $Global:VerifBureau_2 = $false

        #### test console
        Write-Host "c est Bureau: '$Global:Bureau_2'"
        Write-Host "Length: $($Global:Bureau_2.Length)"
        ####

        # Ignore les conditions si "Saisie Manuelle"
        if ($selectedOption -eq "Autre") {
            $LabelBureauError.Text = ''
            $Global:VerifBureau_2 = $true
        }
	
        else {
            # Vérifie les conditions 
            if ($Global:Bureau_2.Length -ne 2) {
                $LabelBureauError.Text = "Le second champ ne doit contenir que 2 chiffres"
            } elseif ($Global:Bureau -notmatch '^[0-9]+$') {
                $LabelBureauError.Text = 'Le champ doit contenir uniquement des chiffres'
            } else {
                $LabelBureauError.Text = ''
                $Global:VerifBureau_2 = $true
                $Global:bur2 = "$Global:bur" + "$Global:Bureau_2"

                $PrintBur = New-Object System.Windows.Forms.Label
                $PrintBur.Location = New-Object System.Drawing.Point(17, 85)
                $PrintBur.Size = New-Object System.Drawing.Size(150, 20)
                $PrintBur.Text = "Numéro de bureau $Global:bur2"
                $tabpage_newuser.Controls.Add($PrintBur)

                $PrintBur.Visible = $false

                if ( $Global:burtest-match '^\d{3}$'){
                    $Global:VfBur = $true
                    $PrintBur.Visible = $true
                    Write-Host "Verification: $Global:burtest"
                    
                }  
                
                
            }
        }
    } elseif ($comboBox.SelectedItem -eq "Saisie Manuelle") {
        $Global:VfBur = $true
        $Global:bur2 = "$Global:bur" + "$Global:Bureau_2"
    } else {
        $LabelBureauError.Text = 'Le champ ne peut pas être vide'
        #### test console
        Write-Host "TextBox est null ou TextBox.Text est null"
        ####
    }
    $Global:bur2 = "$Global:bur" + "$Global:Bureau_2"

    
    #### test  console
    Write-Host "c est Bureau: '$Global:Bureau_2'"
    Write-Host "Length: $($Global:Bureau_2.Length)"
    Write-Host "$Global:bur2"
    Write-Host "Verification: $Global:VerifBureau_2"
    Write-Host "test bureau $Global:burtest"
    #######
    
       
})
#############



$button_generer.Add_Click({

	#modifié
	if (($Global:VerifPrenom -eq 0) -or ($Global:VerifNom -eq 0) -or ($Global:VfBur -eq 0)) {
		return
	}
	if (-not ($Global:VerifPrenom) -or -not ($Global:VerifNom) -or -not ($Global:VfBur)) {
 		[System.Windows.Forms.MessageBox]::Show("Tout les champs ne sont pas complétés.")
	        return
	 } else {
	[System.Windows.Forms.MessageBox]::Show("Veuillez attendre l'onglet validation")
} 
	#####
	
	[String]$Prenom=$TextBoxPrenom.Get_text().Trim(' ')
	[String]$Nom=$TextBoxNom.Get_text().Trim(' ')
	[String]$Service=$ComboBoxService.Get_text().Trim(' ')
	[String]$Telephone=$TextTelephone.Get_text().Trim(' ')
	[String]$Poste=$ComboBoxPoste.Get_text().Trim(' ') 
       
       
        $utilisateur =$env:username.Split(".")[1].ToUpper()
        $From  = "$env:username@cabinet.local"
        $To = 'administrateurs.psnsm@developpement-durable.gouv.fr'
        $body = " Bonjour,

        Ci-dessous la description du PC $env:computername appartenant � $Nom  :

        $Nom $Prenom Bur: $Bureau Tel: $Telephone $Service
       
        Ce rapport a �t� g�n�r� par $utilisateur.

        Merci de v�rifier si ces informations sont correctes" 
        $Subject = 'Check_New_Computer'
        $SmtpServer = 'mail.cabinet.local'
        $Send_mail = Send-MailMessage -From $From -To $To -Subject $Subject  -Body $body -SmtpServer $SmtpServer -port 587 -Encoding unicode

        $donnees = "$Nom,$Prenom,$Global:bur2,$Telephone,$Service,$env:computername"
        $donnees | Out-File "C:\Scripts\Alexis\test_pour_script2\C_$env:computername _ $Nom.txt"

 	####ajout
	$uD = ( Get-ADUser -Filter "samAccountName -like '$($Prenom)*$($Nom)*'").SamAccountName
	$userData = "$Global:bur2,$uD"
	$userData | Out-File -FilePath "C:\Scripts\Alexis\test_pour_script2\U_$uD.txt"
 	#######"
	
	{
		[String]$Description = "$Nom $Prenom Bur: $Bureau Tel: $Telephone $Service"
        [String]$Send_mail = Send-MailMessage -From $From -To $To -Subject $Subject  -Body $body -SmtpServer $SmtpServer -port 587 -Encoding unicode
	}
	
	
	$strCategory = 'Computer'
	$objDomain = New-Object System.DirectoryServices.DirectoryEntry($config.Domaine.CABINET.Connexion.TypeObjectComputer.LDAPPath)
	$objSearcher = New-Object System.DirectoryServices.DirectorySearcher($objDomain,"(& (objectCategory=$strCategory) (CN=$Poste))")
	
	$Computer = $objSearcher.FindOne()
	$objDomainComputer = New-Object System.DirectoryServices.DirectoryEntry($Computer.Path)
	$objDomainComputer.Properties["Location"].Value = $Bureau
	$objDomainComputer.Properties["Description"].Value = $Description
	
	Try {
		$objDomainComputer.CommitChanges()
	}
	
	Catch {
		ChangeLabelError $LabelMessage 'La creation a échoué. Voir les logs'
		get-date >> .\logerrorAD.txt
		$error >> .\logerrorAD.txt
		return
	}

	$LabelMessage.Forecolor = 'Green'
	$LabelMessage.text = "La modfication de $Poste est OK"
   
    <####ajout Onglet de validation    

    #####création du second onglet

    $TabPage2 = New-Object System.Windows.Forms.TabPage
    $TabPage2.Text = "Validation"
    $tabcontrol_Cabinet.TabPages.Add($TabPage2)
    $tabcontrol_Cabinet.SelectedTab = $TabPage2
    
    #####récupère les données de l'utilisateur 
    $user = Get-ADUser -Filter "GivenName -like '$($Prenom)*' -and Surname -like '$($Nom)*'" -Properties *

    #si le user est valide
    if ($user) {

        $NP = $user.Name #récupère nom et prenom
        $Mail = $user.mail #récupère le mail
        $AccountExpirationDate = $user.AccountExpirationDate #récupère la date d'expiration 
        $telephoneNumber = $user.telephoneNumber #récupère le numéro de téléphone
        $Title = $user.Title #récupère le poste 
        $log = $user.SamAccountName #récupère l'idententifiant d'ouverture de session

        #Label pour le prénom
        $OngletBLabelPrenom = New-Object System.Windows.Forms.Label 
        $OngletBLabelPrenom.Location = New-Object System.Drawing.Point(30, 20)
        $OngletBLabelPrenom.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelPrenom.Text = "Nom: $NP"

        #Label pour le mail
        $OngletBLabelMail = New-Object System.Windows.Forms.Label
        $OngletBLabelMail.Location = New-Object System.Drawing.Point(30, 50)
        $OngletBLabelMail.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelMail.Text = "Email: $Mail"
 
        #Label pour l'expiration de compte
        $OngletBLabelAccExp = New-Object System.Windows.Forms.Label
        $OngletBLabelAccExp.Location = New-Object System.Drawing.Point(30, 80)
        $OngletBLabelAccExp.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelAccExp.Text = "Expiration du compte: $AccountExpirationDate"

        #Label pour le numéro de téléphone
        $OngletBLabelPhone = New-Object System.Windows.Forms.Label
        $OngletBLabelPhone.Location = New-Object System.Drawing.Point(30, 110)
        $OngletBLabelPhone.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelPhone.Text = "Numéro de téléphone: $telephoneNumber"

        #Label pour le poste
        $OngletBLabelTitle = New-Object System.Windows.Forms.Label
        $OngletBLabelTitle.Location = New-Object System.Drawing.Point(30, 140)
        $OngletBLabelTitle.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelTitle.Text = "Poste: $Title"
 
        #label pour l identifiant de session
        $OngletBLabelLog = New-Object System.Windows.Forms.Label
        $OngletBLabelLog.Location = New-Object System.Drawing.Point(30, 170)
        $OngletBLabelLog.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelLog.Text = "Login: $log"

        #label pour le bureau 
        $OngletBLabelBur = New-Object System.Windows.Forms.Label
        $OngletBLabelBur.Location = New-Object System.Drawing.Point(30, 200)
        $OngletBLabelBur.size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelBur.Text = "Bureau: $Global:bur2"


        #fonction pour faire afficher les labels sur le second onglet
        $TabPage2.Controls.Add($OngletBLabelPrenom)
        $TabPage2.Controls.Add($OngletBLabelMail)
        $TabPage2.Controls.Add($OngletBLabelAccExp)
        $TabPage2.Controls.Add($OngletBLabelPhone)
        $TabPage2.Controls.Add($OngletBLabelTitle)
        $TabPage2.Controls.Add($OngletBLabelLog)
        $TabPage2.Controls.Add($OngletBLabelBur)
        
        #Bouton Problème
        #Création 
        $BtnPb = New-Object System.Windows.Forms.Button
        $BtnPb.Text = "Signaler un problème"
        $BtnPb.Location = New-Object System.Drawing.Point(30, 230)
        $BtnPb.Size = New-Object System.Drawing.Size(200, 30)

        #event quand cliqué
        $BtnPb.Add_Click({
            #crée une zone de texte et son label
            $Formulaire = New-Object System.Windows.Forms.Form
            $Formulaire.Text = "Signaler un problème"
            $Formulaire.Size = New-Object System.Drawing.Size(400, 200)
            $FormText = New-Object System.Windows.Forms.TextBox
            $FormText.Location = New-Object System.Drawing.Point(20, 20)
            $FormText.Size = New-Object System.Drawing.Size(350, 20)

            #crée un bouton pour soumettre le texte
            $BntEnvoi = New-Object System.Windows.Forms.Button
            $BntEnvoi.Text = "Envoyer"
            $BntEnvoi.Location = New-Object System.Drawing.Point(150, 60)

            #quand bouton cliqué 
            $BntEnvoi.Add_Click({

                #envoie un mail avec le texte 
                $utilisateur =$env:username.Split(".")[1].ToUpper()
                $From  = "$env:username@cabinet.local"
                $To = 'administrateurs.psnsm@developpement-durable.gouv.fr'
                $body = " Bonjour,
       
                Un problème a été signalé par $utilisateur.
                $problemDescription

                Merci de v�rifier si ces informations sont correctes" 

                $Subject = 'Check_New_Computer'
                $SmtpServer = 'mail.cabinet.local'
                $Send_mail = Send-MailMessage -From $From -To $To -Subject $Subject  -Body $body -SmtpServer $SmtpServer -port 587 -Encoding unicode
            })
            $Formulaire.Controls.Add($FormText)
            $Formulaire.Controls.Add($BntEnvoi)
            $Formulaire.ShowDialog()
        })

        #Bouton téléphone
        $BtnTel = New-Object System.Windows.Forms.Button
        $BtnTel.Text = "Numéro de téléphone erroné"
        $BtnTel.Location = New-Object System.Drawing.Point(30, 260)
        $BtnTel.Size = New-Object System.Drawing.Size(200, 30)

        #quand cliqué
        $BtnTel.Add_Click({
            $FormulaireTel = New-Object System.Windows.Forms.Form
            $FormulaireTel.Text = "Numéro de téléphone erroné"
            $FormulaireTel.Size = New-Object System.Drawing.Size(300, 200)

            crée un bouton
            
            $Absent = New-Object System.Windows.Forms.Button
            $Absent.Text = "Numéro absent"
            $Absent.Location = New-Object System.Drawing.Point(50, 20)
            $Absent.Size = New-Object System.Drawing.Size(200, 30)
            $Absent.Add_Click({
                $utilisateur =$env:username.Split(".")[1].ToUpper()
                $From  = "$env:username@cabinet.local"
                $To = 'administrateurs.psnsm@developpement-durable.gouv.fr'
                $body = " Bonjour,

                $utilisateur signale que le numéro de téléphone est absent

                Merci de v�rifier si ces informations sont correctes" 
                $Subject = 'Check_New_Computer'
                $SmtpServer = 'mail.cabinet.local'
                $Send_mail = Send-MailMessage -From $From -To $To -Subject $Subject  -Body $body -SmtpServer $SmtpServer -port 587 -Encoding unicode
            })
    
            $letterErrorButton = New-Object System.Windows.Forms.Button
            $letterErrorButton.Text = "Format non respecté"
            $letterErrorButton.Location = New-Object System.Drawing.Point(50, 100)
            $letterErrorButton.Size = New-Object System.Drawing.Size(200, 30)
            $letterErrorButton.Add_Click({
                $utilisateur =$env:username.Split(".")[1].ToUpper()
                $From  = "$env:username@cabinet.local"
                $To = 'administrateurs.psnsm@developpement-durable.gouv.fr'
                $body = " Bonjour,

                $utilisateur signale que le numéro ne respecte pas la convention du format.

                Merci de v�rifier si ces informations sont correctes" 
                $Subject = 'Check_New_Computer'
                $SmtpServer = 'mail.cabinet.local'
                $Send_mail = Send-MailMessage -From $From -To $To -Subject $Subject  -Body $body -SmtpServer $SmtpServer -port 587 -Encoding unicode
                $FormulaireTel.Close()
            })


            $Taille = New-Object System.Windows.Forms.Button
            $Taille.Text = "Taille du numéro erroné"
            $Taille.Location = New-Object System.Drawing.Point(50, 60)
            $Taille.Size = New-Object System.Drawing.Size(200, 30)
            $Taille.Add_Click({
                $utilisateur =$env:username.Split(".")[1].ToUpper()
                $From  = "$env:username@cabinet.local"
                $To = 'administrateurs.psnsm@developpement-durable.gouv.fr'
                $body = " Bonjour,

                $utilisateur signale que la taille du numéro de téléphone est erroné.

                Merci de v�rifier si ces informations sont correctes" 
                $Subject = 'Check_New_Computer'
                $SmtpServer = 'mail.cabinet.local'
                $Send_mail = Send-MailMessage -From $From -To $To -Subject $Subject  -Body $body -SmtpServer $SmtpServer -port 587 -Encoding unicode
                $FormulaireTel.Close()
            })
    
            $Autre = New-Object System.Windows.Forms.Button
            $Autre.Text = "Autre"
            $Autre.Location = New-Object System.Drawing.Point(50, 140)
            $Autre.Size = New-Object System.Drawing.Size(200, 30)
            $Autre.Add_Click({
                $utilisateur =$env:username.Split(".")[1].ToUpper()
                $From  = "$env:username@cabinet.local"
                $To = 'administrateurs.psnsm@developpement-durable.gouv.fr'
                $body = " Bonjour,

                $utilisateur signale qu'une erreur est présentes

                Merci de v�rifier si ces informations sont correctes" 
                $Subject = 'Check_New_Computer'
                $SmtpServer = 'mail.cabinet.local'
                $Send_mail = Send-MailMessage -From $From -To $To -Subject $Subject  -Body $body -SmtpServer $SmtpServer -port 587 -Encoding unicode
                $FormulaireTel.Close()
            })
    
            $FormulaireTel.Controls.Add($Absent)
            $FormulaireTel.Controls.Add($Taille)
            $FormulaireTel.Controls.Add($Autre)
            $FormulaireTel.Controls.Add($letterErrorButton)
            $FormulaireTel.ShowDialog()
        })

        $TabPage2.Controls.Add($BtnPb)
        $TabPage2.Controls.Add($BtnTel)

    } else {
        [System.Windows.Forms.MessageBox]::Show("Utilisateur non trouvé.")
    }
    #########

    # ajout Vérifie si le numéro de téléphone n'est pas renseigné
    if ($Telephone -eq $null -or $Telephone -eq '') {


        $utilisateur =$env:username.Split(".")[1].ToUpper()
        #a changer
        $From  = "$env:username@cabinet.local"
        $To = 'administrateurs.psnsm@developpement-durable.gouv.fr'
        $body = " Bonjour,

        Le numéro de $Nom $Prenom Bur: $Bureau n'a pas été enregistré.
         
        Merci de vérifier si cette information est correcte
       
        Ce rapport a été généré par $utilisateur."
         
        $Subject = 'Check_New_Computer'
        $SmtpServer = 'mail.cabinet.local'
        $Send_mail = Send-MailMessage -From $From -To $To -Subject $Subject  -Body $body -SmtpServer $SmtpServer -port 587 -Encoding unicode

    }  
    #>
})

# Cherche les valeurs des OU des services
$Clients  = Get-InfoDomaine 'organizationalUnit' $config.Domaine.CABINET.Connexion.TypeObjectOU.LDAPPath 'Name' 'OneLevel'
$Clients | Sort-Object | Foreach-object {$ComboBoxService.Items.Add($_)}

$comboBoxPoste.Items.Add($env:COMPUTERNAME)

#Définit la valeur par défaut des listes déroulantes
$ComboBoxService.SelectedIndex=0
$comboBoxPoste.Selectedindex=0

#
# button_quitter
#
$button_quitter.Location = New-Object System.Drawing.Point(450, 400)
$button_quitter.Name = 'button_quitter'
$button_quitter.Size = New-Object System.Drawing.Size(94, 24)
$button_quitter.TabIndex = 9
$button_quitter.Text = 'Quitter'
$button_quitter.UseVisualStyleBackColor = $true
$button_quitter.Add_Click({$Form10.close()})
#
# button_generer
#
$button_generer.Location = New-Object System.Drawing.Point(53, 400)
$button_generer.Name = 'button_generer'
$button_generer.Size = New-Object System.Drawing.Size(94, 24)
$button_generer.TabIndex = 8
$button_generer.Text = 'Generer'
$button_generer.UseVisualStyleBackColor = $true
#
# LabelPrenom
#
$LabelPrenom.AutoSize = $true
$LabelPrenom.Location = New-Object System.Drawing.Point(15, 105)
$LabelPrenom.Name = 'LabelPrenom'
$LabelPrenom.Size = New-Object System.Drawing.Size(129, 15)
$LabelPrenom.Text = 'Prenom'
#
# LabelPrenomError
#
$LabelPrenomError.AutoSize = $true
$LabelPrenomError.Location = New-Object System.Drawing.Point(375, 105)
$LabelPrenomError.Name = 'LabelPrenomError'
$LabelPrenomError.Size = New-Object System.Drawing.Size(129, 15)
$LabelPrenomError.Text = ''
#
# LabelNom
#
$LabelNom.AutoSize = $true
$LabelNom.Location = New-Object System.Drawing.Point(15, 155)
$LabelNom.Name = 'LabelNom'
$LabelNom.Size = New-Object System.Drawing.Size(71, 13)
$LabelNom.Text = 'Nom'
#
# LabelNomError
#
$LabelNomError.AutoSize = $true
$LabelNomError.Location = New-Object System.Drawing.Point(375, 155)
$LabelNomError.Name = 'LabelNomError'
$LabelNomError.Size = New-Object System.Drawing.Size(71, 13)
#
# LabelTelephone
#
$LabelTelephone.AutoSize = $true
$LabelTelephone.Location = New-Object System.Drawing.Point(15, 255)
$LabelTelephone.Name = 'LabelTelephone'
$LabelTelephone.Size = New-Object System.Drawing.Size(71, 13)
$LabelTelephone.Text = 'Telephone (optionel)'
#
# LabelPoste
#
$LabelPoste.AutoSize = $true
$LabelPoste.Location = New-Object System.Drawing.Point(15, 305)
$LabelPoste.Name = 'LabelNumeroEmploye'
$LabelPoste.Size = New-Object System.Drawing.Size(71, 13)
$LabelPoste.Text = 'Poste'
#
# LabelTelephoneError
#
$LabelTelephoneError.AutoSize = $true
$LabelTelephoneError.Location = New-Object System.Drawing.Point(260, 255)
$LabelTelephoneError.Name = 'LabelTelephoneError'
$LabelTelephoneError.Size = New-Object System.Drawing.Size(71, 13)
$LabelTelephoneError.Text = ''
#
# Labelservice
#
$Labelservice.AutoSize = $true
$Labelservice.Location = New-Object System.Drawing.Point(15, 205)
$Labelservice.Name = 'Labelservice'
$Labelservice.Size = New-Object System.Drawing.Size(71, 13)
$Labelservice.Text = 'Service'
#
# LabelMessage
#
$LabelMessage.AutoSize = $true
$LabelMessage.Location = New-Object System.Drawing.Point(200, 445)
$LabelMessage.Name = 'LabelMessage'
$LabelMessage.Text = ''
#
# TextBoxPrenom
#
$TextBoxPrenom.Location = New-Object System.Drawing.Point(150, 105)
$TextBoxPrenom.Name = 'TextBoxPrenom'
$TextBoxPrenom.Size = New-Object System.Drawing.Size(200, 20)
$TextBoxPrenom.TabIndex = 2
#
# TextBoxNom
#
$TextBoxNom.Location = New-Object System.Drawing.Point(150, 155)
$TextBoxNom.Name = 'TextBoxNom'
$TextBoxNom.Size = New-Object System.Drawing.Size(200, 20)
$TextBoxNom.TabIndex = 3
#
# TextTelephone
#
$TextTelephone.Location = New-Object System.Drawing.Point(150, 255)
$TextTelephone.MaxLength = 7
$TextTelephone.Name = 'TextTelephone'
$TextTelephone.Size = New-Object System.Drawing.Size(100, 20)
$TextTelephone.TabIndex = 5
#
# ComboBoxPoste
#
$ComboBoxPoste.Location = New-Object System.Drawing.Point(150, 305)
$ComboBoxPoste.Name = 'ComboBoxPoste'
$ComboBoxPoste.Size = New-Object System.Drawing.Size(200, 20)
$ComboBoxPoste.TabIndex = 6
$ComboBoxPoste.DropDownStyle='DropDownList'

#
# ComboBoxService
#
$ComboBoxService.Location = New-Object System.Drawing.Point(150, 205)
$ComboBoxService.Name = 'ComboBoxService'
$ComboBoxService.Size = New-Object System.Drawing.Size(200, 20)
$ComboBoxService.DropDownStyle='DropDownList'
$ComboBoxService.TabIndex = 4
#
# tabpage_newuser
#
$tabpage_newuser.AutoSize = $true
$tabpage_newuser.Location = New-Object System.Drawing.Point(4, 32)
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