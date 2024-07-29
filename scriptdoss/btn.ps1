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
    
    $absentButton = New-Object System.Windows.Forms.Button
    $absentButton.Text = "Numéro absent"
    $absentButton.Location = New-Object System.Drawing.Point(50, 20)
    $absentButton.Size = New-Object System.Drawing.Size(200, 30)
    $absentButton.Add_Click({
        Send-Email -subject "Erreur de numéro" -body "Numéro absent"
        $FormulaireTel.Close()
    })
    
    $sizeErrorButton = New-Object System.Windows.Forms.Button
    $sizeErrorButton.Text = "Taille du numéro erroné"
    $sizeErrorButton.Location = New-Object System.Drawing.Point(50, 60)
    $sizeErrorButton.Size = New-Object System.Drawing.Size(200, 30)
    $sizeErrorButton.Add_Click({
        Send-Email -subject "Erreur de numéro" -body "Taille du numéro erroné"
        $FormulaireTel.Close()
    })
    
    $letterErrorButton = New-Object System.Windows.Forms.Button
    $letterErrorButton.Text = "Lettre dans le numéro"
    $letterErrorButton.Location = New-Object System.Drawing.Point(50, 100)
    $letterErrorButton.Size = New-Object System.Drawing.Size(200, 30)
    $letterErrorButton.Add_Click({
        Send-Email -subject "Erreur de numéro" -body "Lettre dans le numéro"
        $FormulaireTel.Close()
    })
    
    $otherButton = New-Object System.Windows.Forms.Button
    $otherButton.Text = "Autre"
    $otherButton.Location = New-Object System.Drawing.Point(50, 140)
    $otherButton.Size = New-Object System.Drawing.Size(200, 30)
    $otherButton.Add_Click({
        $errorType = [System.Windows.Forms.MessageBox]::Show("Entrez l'erreur:", "Erreur de numéro", [System.Windows.Forms.MessageBoxButtons]::OKCancel)
        if ($errorType -eq "OK") {
            $errorDescription = [System.Windows.Forms.MessageBox]::Show("Entrez la description de l'erreur:", "Erreur de numéro", [System.Windows.Forms.MessageBoxButtons]::OKCancel)
            if ($errorDescription -eq "OK") {
                Send-Email -subject "Erreur de numéro" -body $errorDescription
            }
        }
        $FormulaireTel.Close()
    })
    
    $FormulaireTel.Controls.Add($absentButton)
    $FormulaireTel.Controls.Add($sizeErrorButton)
    $FormulaireTel.Controls.Add($letterErrorButton)
    $FormulaireTel.Controls.Add($otherButton)
    $FormulaireTel.ShowDialog()
})

$form.Controls.Add($BtnPb)
$form.Controls.Add($BtnTel)

[void] $form.ShowDialog()
