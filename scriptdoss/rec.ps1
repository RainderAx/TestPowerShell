# Importer le module Windows Forms
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

[void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
$Form10 = New-Object System.Windows.Forms.Form
$Form10.ClientSize = '500,500' # Taille de la fenêtre
$Form10.Text = "Mon UI en PS avec onglets" # Titre de la fenêtre
$Form10.FormBorderStyle = 'Fixed3D'
$Form10.MaximizeBox = $false

# Déclaration des objets de l'interface
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

# Ajout du TextBox pour le login
$TextBoxLogin = New-Object System.Windows.Forms.TextBox
$LabelLogin = New-Object System.Windows.Forms.Label

$tabcontrol_Cabinet = New-Object System.Windows.Forms.TabControl
$tabpage_newuser = New-Object System.Windows.Forms.TabPage
$tabpage_newuser.Text = "Nouvel Utilisateur"

# Créer et configurer le MenuStrip
$Menu = New-Object System.Windows.Forms.MenuStrip
$Menu.Location = New-Object System.Drawing.Point(0, 0)
$Menu.ShowItemToolTips = $true

$MenuFileQuit = New-Object System.Windows.Forms.ToolStripMenuItem
$MenuFileQuit.Text = " &Quitter "
$MenuFileQuit.ToolTipText = " Infobulle d’aide "
$MenuFileQuit.Add_Click({ $Form10.Close() })
$Menu.Items.Add($MenuFileQuit)

# Créer et configurer le TabControl
$TabControl = New-Object System.Windows.Forms.TabControl
$TabControl.Dock = [System.Windows.Forms.DockStyle]::Fill

$TabPage2 = New-Object System.Windows.Forms.TabPage
$TabPage2.Text = "Onglet B"

$TabControl.TabPages.Add($tabpage_newuser)
$TabControl.TabPages.Add($TabPage2)

# Ajouter le TabControl au formulaire
$Form10.Controls.Add($TabControl)

# Contenu de l'Onglet Nouvel Utilisateur
$TextBoxPrenom.Location = New-Object System.Drawing.Point(150, 30)
$TextBoxNom.Location = New-Object System.Drawing.Point(150, 60)
$TextTelephone.Location = New-Object System.Drawing.Point(150, 90)
$button_generer.Location = New-Object System.Drawing.Point(150, 120)
$button_quitter.Location = New-Object System.Drawing.Point(250, 120)

$LabelPrenom.Location = New-Object System.Drawing.Point(30, 30)
$LabelPrenom.Text = "Prénom:"
$LabelNom.Location = New-Object System.Drawing.Point(30, 60)
$LabelNom.Text = "Nom:"
$LabelTelephone.Location = New-Object System.Drawing.Point(30, 90)
$LabelTelephone.Text = "Téléphone:"
$LabelPoste.Location = New-Object System.Drawing.Point(30, 150)
$LabelPoste.Text = "Poste:"
$Labelservice.Location = New-Object System.Drawing.Point(30, 180)
$Labelservice.Text = "Service:"

$ComboBoxService.Location = New-Object System.Drawing.Point(150, 180)
$ComboBoxPoste.Location = New-Object System.Drawing.Point(150, 150)

$TextBoxLogin.Location = New-Object System.Drawing.Point(150, 210)
$LabelLogin.Location = New-Object System.Drawing.Point(30, 210)
$LabelLogin.Text = "Login:"

$LabelPrenomError.Location = New-Object System.Drawing.Point(300, 30)
$LabelNomError.Location = New-Object System.Drawing.Point(300, 60)
$LabelTelephoneError.Location = New-Object System.Drawing.Point(300, 90)

# Ajouter les contrôles à l'onglet Nouvel Utilisateur
$tabpage_newuser.Controls.AddRange(@(
    $TextBoxPrenom, $TextBoxNom, $TextTelephone, $button_generer, $button_quitter,
    $LabelPrenom, $LabelPrenomError, $LabelNom, $LabelNomError, $LabelTelephone, $LabelTelephoneError,
    $LabelPoste, $Labelservice, $ComboBoxService, $ComboBoxPoste, $TextBoxLogin, $LabelLogin
))

# Fonctions et événements des contrôles
$TextBoxNom.Add_textChanged({
    $TextBoxNom.Text = ($TextBoxNom.Get_Text()).ToUpper()
    $TextBoxNom.SelectionStart = $TextBoxNom.Text.Length
    $TextBoxNom.SelectionLength = 0
})

$TextBoxPrenom.Add_textChanged({
    $TextBoxPrenom.Text = (Get-Culture).TextInfo.ToTitleCase($TextBoxPrenom.Text.Split(' '))
    $TextBoxPrenom.SelectionStart = $TextBoxPrenom.Text.Length
    $TextBoxPrenom.SelectionLength = 0
})

$TextTelephone.Add_LostFocus({
    if ($TextTelephone.Text.Length -eq 0) {
        ChangeLabelOk $LabelTelephoneError
        $Global:VerifTelephone = $false
        return
    } elseif ($TextTelephone.Text.Length -ne 5) {
        ChangeLabelError $LabelTelephoneError 'Merci de mettre que les 5 derniers numéros'
        $Global:VerifTelephone = $false
        return
    }

    Try {
        [int]$TestTelephone = $TextTelephone.Text
    } Catch [System.Management.Automation.PSInvalidCastException] {
        $Global:VerifTelephone = $false
        ChangeLabelError $LabelTelephoneError 'Le champ doit contenir que des chiffres'
        return
    }
    $Global:VerifTelephone = $true
    ChangeLabelOk $LabelTelephoneError
})

$TextBoxPrenom.Add_LostFocus({
    if ($Global:VerifPrenom -eq $true) {
        return
    }

    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ '

    for ($i = 0; $i -lt ($TextBoxPrenom.Text).Length; $i++) {
        if ($chars -match $TextBoxPrenom.Text[$i] -ne $true) {
            ChangeLabelError $LabelPrenomError 'Le champ doit contenir que des lettres'
            $Global:VerifPrenom = $false
            Break
        } else {
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

    for ($i = 0; $i -lt ($TextBoxNom.Text).Length; $i++) {
        if ($chars -match $TextBoxNom.Text[$i] -ne $true) {
            ChangeLabelError $LabelNomError 'Le champ doit contenir que des lettres'
            $Global:VerifNom = $false
            Break
        } else {
            $Global:VerifNom = $true
        }
    }
    if ($Global:VerifNom -eq $true) {
        ChangeLabelOK $LabelNomError
    }
})

function MultiPrenom {
    Param($Prenom = $args[0])
    $MultiPrenom = ''
    for ($i = 0; $i -lt ($Prenom.Split(' ')).Count; $i++) {
        $MultiPrenom += $Prenom.Split(' ')[$i][0]
    }
    return $MultiPrenom
}

function InitialPrenom {
    Param($Prenom = $args[0])

    if (($Prenom.Split(' ')).Count -eq 1) {
        return $Prenom[0]
    } elseif (($Prenom.Split(' ')).Count -ge 2) {
        $InitialPrenom = MultiPrenom $Prenom
        return $InitialPrenom
    }
}

function ChangeLabelError {
    Param($LabelError = $args[0], $TextError = $args[1])
    $LabelError.ForeColor = 'Red'
    $LabelError.Text = $TextError
}

function ChangeLabelOk {
    Param($LabelError = $args[0])
    $LabelError.ForeColor = 'Green'
    $LabelError.Text = 'OK'
}

function Generate-Pwd {
    Param(
        [bool]$chiffres = $args[0],
        [bool]$minuscules = $args[1],
        [bool]$majuscules = $args[2],
        [bool]$autres = $args[3],
        [int]$len = $args[4]
    )
    [string]$chars = ''
    $complex = 0

    if ($chiffres -eq 1) { $chars += '0123456789'; $complex += 1 }
    if ($majuscules -eq 1) { $chars += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; $complex += 1 }
    if ($minuscules -eq 1) { $chars += 'abcdefghijklmnopqrstuvwxyz'; $complex += 1 }
    if ($autres -eq 1) { $chars += '_!@#$%'; $complex += 1 }

    if ($chars -ne '') {
        $bytes = New-Object 'System.Byte[]' $len
        $rnd = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
        $rnd.GetBytes($bytes)
        $result = ''
        for ($i = 0; $i -lt $len; $i++) {
            $result += $chars[$bytes[$i] % $chars.Length]
        }
        return $result
    }
}

function Get-InfoDomaine {
    Param(
        $strCategory = $args[0],
        $DirectoryEntry = $args[1],
        $Element = $args[2],
        $Scope = $args[3]
    )
    $objDomain = New-Object System.DirectoryServices.DirectoryEntry($DirectoryEntry)
    $objSearcher = New-Object System.DirectoryServices.DirectorySearcher($objDomain, "(objectCategory=$strCategory)")
    $objSearcher.PageSize = 200
    $colResults = $objSearcher.FindAll()
    $lstResult = @()

    foreach ($objResult in $colResults) {
        if ($objResult.Properties[$Element] -ne $null) {
            $lstResult += $objResult.Properties[$Element]
        }
    }
    $lstResult = $lstResult | Sort-Object

    if ($Scope -eq 'Poste') {
        $lstResult | ForEach-Object {
            $Item = $_.Split(',')
            if ($Item.Count -eq 1) {
                [void]$ComboBoxPoste.Items.Add($_)
            } elseif ($Item.Count -eq 2) {
                if ($Item[1] -eq $null) {
                    [void]$ComboBoxPoste.Items.Add($_)
                } else {
                    [void]$ComboBoxPoste.Items.Add($Item[0] + ' - ' + $Item[1])
                }
            }
        }
    } elseif ($Scope -eq 'Service') {
        $lstResult | ForEach-Object {
            [void]$ComboBoxService.Items.Add($_)
        }
    }
}

function PopulateComboBox {
    $ComboBoxService.Items.Clear()
    $ComboBoxPoste.Items.Clear()
    Get-InfoDomaine 'organizationalUnit' $directoryEntry 'name' 'Service'
    Get-InfoDomaine 'group' $directoryEntry 'name' 'Poste'
}

$button_generer.Add_Click({
    if ($Global:VerifPrenom -eq $false -or $Global:VerifNom -eq $false -or $Global:VerifTelephone -eq $false) {
        [System.Windows.Forms.MessageBox]::Show("Veuillez vérifier les informations saisies", "Erreur", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }

    $Prenom = $TextBoxPrenom.Text
    $Nom = $TextBoxNom.Text
    $Telephone = $TextTelephone.Text
    $Service = $ComboBoxService.Text
    $Poste = $ComboBoxPoste.Text

    $InitialPrenom = InitialPrenom $Prenom
    $Login = $InitialPrenom + $Nom
    $TextBoxLogin.Text = $Login

    $Password = Generate-Pwd -chiffres $true -minuscules $true -majuscules $true -autres $true -len 12

    [System.Windows.Forms.MessageBox]::Show("Le mot de passe généré est : $Password", "Mot de passe", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

$button_quitter.Add_Click({
    $Form10.Close()
})

# Afficher la fenêtre
[void]$Form10.Controls.Add($Menu)
[void]$Form10.MainMenuStrip = $Menu
[void]$Form10.ShowDialog()
