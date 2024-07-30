Échec lors de l’appel de la méthode, car [System.Windows.Forms.TabPage] ne contient pas de méthode nommée « ShowDialog ».
Au caractère C:\Scripts\Alexis\doss\Sans titre8.ps1:734 : 13
+             $TabPage2.ShowDialog()
+             ~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation : (:) [], RuntimeException
    + FullyQualifiedErrorId : MethodNotFound

        ####ajout Onglet de validation    
    $TabPage2 = New-Object System.Windows.Forms.TabPage
    $TabPage2.Text = "Validation"
    $tabcontrol_Cabinet.TabPages.Add($TabPage2)
    $tabcontrol_Cabinet.SelectedTab = $TabPage2
    
    $user = Get-ADUser -Filter "GivenName -like '$($Prenom)*' -and Surname -like '$($Nom)*'" -Properties *

    if ($user) {
        $NP = $user.Name
        $Mail = $user.mail 
        $AccountExpirationDate = $user.AccountExpirationDate
        $telephoneNumber = $user.telephoneNumber
        $Title = $user.Title
        $log = $user.SamAccountName

        $OngletBLabelPrenom = New-Object System.Windows.Forms.Label
        $OngletBLabelPrenom.Location = New-Object System.Drawing.Point(30, 20)
        $OngletBLabelPrenom.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelPrenom.Text = "Nom: $NP"

        $OngletBLabelMail = New-Object System.Windows.Forms.Label
        $OngletBLabelMail.Location = New-Object System.Drawing.Point(30, 50)
        $OngletBLabelMail.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelMail.Text = "Email: $Mail"
 
        $OngletBLabelAccExp = New-Object System.Windows.Forms.Label
        $OngletBLabelAccExp.Location = New-Object System.Drawing.Point(30, 80)
        $OngletBLabelAccExp.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelAccExp.Text = "Expiration du compte: $AccountExpirationDate"

        $OngletBLabelPhone = New-Object System.Windows.Forms.Label
        $OngletBLabelPhone.Location = New-Object System.Drawing.Point(30, 110)
        $OngletBLabelPhone.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelPhone.Text = "Numéro de téléphone: $telephoneNumber"

        $OngletBLabelTitle = New-Object System.Windows.Forms.Label
        $OngletBLabelTitle.Location = New-Object System.Drawing.Point(30, 140)
        $OngletBLabelTitle.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelTitle.Text = "Poste: $Title"
 
        $OngletBLabelLog = New-Object System.Windows.Forms.Label
        $OngletBLabelLog.Location = New-Object System.Drawing.Point(30, 170)
        $OngletBLabelLog.Size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelLog.Text = "Login: $log"

        $OngletBLabelBur = New-Object System.Windows.Forms.Label
        $OngletBLabelBur.Location = New-Object System.Drawing.Point(30, 200)
        $OngletBLabelBur.size = New-Object System.Drawing.Size(300, 20)
        $OngletBLabelBur.Text = "Bureau: $Global:bur2"

        $TabPage2.Controls.Add($OngletBLabelPrenom)
        $TabPage2.Controls.Add($OngletBLabelMail)
        $TabPage2.Controls.Add($OngletBLabelAccExp)
        $TabPage2.Controls.Add($OngletBLabelPhone)
        $TabPage2.Controls.Add($OngletBLabelTitle)
        $TabPage2.Controls.Add($OngletBLabelLog)
        $TabPage2.Controls.Add($OngletBLabelBur)
        
        #Bouton Problème
        $BtnPb = New-Object System.Windows.Forms.Button
        $BtnPb.Text = "Signaler un problème"
        $BtnPb.Location = New-Object System.Drawing.Point(30, 230)
        $BtnPb.Size = New-Object System.Drawing.Size(200, 30)
        $BtnPb.Add_Click({
            $Formulaire = New-Object System.Windows.Forms.Form
            $Formulaire.Text = "Signaler un problème"
            $Formulaire.Size = New-Object System.Drawing.Size(400, 200)
    
            $FormText = New-Object System.Windows.Forms.TextBox
            $FormText.Location = New-Object System.Drawing.Point(20, 20)
            $FormText.Size = New-Object System.Drawing.Size(350, 20)
    
            $BntEnvoi = New-Object System.Windows.Forms.Button
            $BntEnvoi.Text = "Envoyer"
            $BntEnvoi.Location = New-Object System.Drawing.Point(150, 60)
            $BntEnvoi.Add_Click({
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
    
            $TabPage2.Controls.Add($FormText)
            $TabPage2.Controls.Add($BntEnvoi)
            $TabPage2.ShowDialog()
        })

        #Bouton téléphone
        $BtnTel = New-Object System.Windows.Forms.Button
        $BtnTel.Text = "Numéro de téléphone erroné"
        $BtnTel.Location = New-Object System.Drawing.Point(30, 260)
        $BtnTel.Size = New-Object System.Drawing.Size(200, 30)
        $BtnTel.Add_Click({
            $FormulaireTel = New-Object System.Windows.Forms.Form
            $FormulaireTel.Text = "Numéro de téléphone erroné"
            $FormulaireTel.Size = New-Object System.Drawing.Size(300, 200)
    
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
