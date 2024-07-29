Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Main Menu"
$form.Size = New-Object System.Drawing.Size(300, 200)

#Bouton Problème
$BtnPb = New-Object System.Windows.Forms.Button
$BtnPb.Text = "Signaler un problème"
$BtnPb.Location = New-Object System.Drawing.Point(50, 30)
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
        $problemDescription = $FormText.Text
        Send-Email -subject "Reported Problem" -body $problemDescription
        $Formulaire.Close()
    })
    
    $Formulaire.Controls.Add($FormText)
    $Formulaire.Controls.Add($BntEnvoi)
    $Formulaire.ShowDialog()
})

#Bouton téléphone
$BtnTel = New-Object System.Windows.Forms.Button
$BtnTel.Text = "Numéro de téléphone erroné"
$BtnTel.Location = New-Object System.Drawing.Point(50, 80)
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
        Send-Email -subject "Erreur de numéro" -body "Numéro absent"
        $FormulaireTel.Close()
    })
    
    $Taille = New-Object System.Windows.Forms.Button
    $Taille.Text = "Taille du numéro erroné"
    $Taille.Location = New-Object System.Drawing.Point(50, 60)
    $Taille.Size = New-Object System.Drawing.Size(200, 30)
    $Taille.Add_Click({
        Send-Email -subject "Erreur de numéro" -body "Taille du numéro erroné"
        $FormulaireTel.Close()
    })
    
    $Autre = New-Object System.Windows.Forms.Button
    $Autre.Text = "Autre"
    $Autre.Location = New-Object System.Drawing.Point(50, 140)
    $Autre.Size = New-Object System.Drawing.Size(200, 30)
    $Autre.Add_Click({
        $errorType = [System.Windows.Forms.MessageBox]::Show("Entrez l'erreur:", "Erreur de numéro", [System.Windows.Forms.MessageBoxButtons]::OKCancel)
        if ($errorType -eq "OK") {
            $errorDescription = [System.Windows.Forms.MessageBox]::Show("Entrez la description de l'erreur:", "Erreur de numéro", [System.Windows.Forms.MessageBoxButtons]::OKCancel)
            if ($errorDescription -eq "OK") {
                Send-Email -subject "Erreur de numéro" -body $errorDescription
            }
        }
        $FormulaireTel.Close()
    })
    
    $FormulaireTel.Controls.Add($Absent)
    $FormulaireTel.Controls.Add($Taille)
    $FormulaireTel.Controls.Add($Autre)
    $FormulaireTel.ShowDialog()
})

$form.Controls.Add($BtnPb)
$form.Controls.Add($BtnTel)

[void] $form.ShowDialog()
