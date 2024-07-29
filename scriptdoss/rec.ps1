Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to send email
function Send-Email {
    param (
        [string]$subject,
        [string]$body
    )
    
    $smtpServer = "smtp.example.com"
    $smtpFrom = "from@example.com"
    $smtpTo = "to@example.com"
    
    $message = New-Object system.net.mail.mailmessage
    $message.from = $smtpFrom
    $message.To.Add($smtpTo)
    $message.Subject = $subject
    $message.Body = $body
    
    $smtp = New-Object Net.Mail.SmtpClient($smtpServer)
    try {
        $smtp.Send($message)
        [System.Windows.Forms.MessageBox]::Show("Email sent successfully.")
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to send email: $_")
    }
}

# Main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Main Menu"
$form.Size = New-Object System.Drawing.Size(300, 200)

# Report Problem Button
$buttonReportProblem = New-Object System.Windows.Forms.Button
$buttonReportProblem.Text = "Signaler un problème"
$buttonReportProblem.Location = New-Object System.Drawing.Point(50, 30)
$buttonReportProblem.Size = New-Object System.Drawing.Size(200, 30)
$buttonReportProblem.Add_Click({
    $reportForm = New-Object System.Windows.Forms.Form
    $reportForm.Text = "Signaler un problème"
    $reportForm.Size = New-Object System.Drawing.Size(400, 200)
    
    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(20, 20)
    $textBox.Size = New-Object System.Drawing.Size(350, 20)
    
    $submitButton = New-Object System.Windows.Forms.Button
    $submitButton.Text = "Submit"
    $submitButton.Location = New-Object System.Drawing.Point(150, 60)
    $submitButton.Add_Click({
        $problemDescription = $textBox.Text
        Send-Email -subject "Reported Problem" -body $problemDescription
        $reportForm.Close()
    })
    
    $reportForm.Controls.Add($textBox)
    $reportForm.Controls.Add($submitButton)
    $reportForm.ShowDialog()
})

# Phone Number Error Button
$buttonPhoneError = New-Object System.Windows.Forms.Button
$buttonPhoneError.Text = "Numéro de téléphone erroné"
$buttonPhoneError.Location = New-Object System.Drawing.Point(50, 80)
$buttonPhoneError.Size = New-Object System.Drawing.Size(200, 30)
$buttonPhoneError.Add_Click({
    $phoneForm = New-Object System.Windows.Forms.Form
    $phoneForm.Text = "Numéro de téléphone erroné"
    $phoneForm.Size = New-Object System.Drawing.Size(300, 200)
    
    $absentButton = New-Object System.Windows.Forms.Button
    $absentButton.Text = "Numéro absent"
    $absentButton.Location = New-Object System.Drawing.Point(50, 20)
    $absentButton.Size = New-Object System.Drawing.Size(200, 30)
    $absentButton.Add_Click({
        Send-Email -subject "Erreur de numéro" -body "Numéro absent"
        $phoneForm.Close()
    })
    
    $sizeErrorButton = New-Object System.Windows.Forms.Button
    $sizeErrorButton.Text = "Taille du numéro erroné"
    $sizeErrorButton.Location = New-Object System.Drawing.Point(50, 60)
    $sizeErrorButton.Size = New-Object System.Drawing.Size(200, 30)
    $sizeErrorButton.Add_Click({
        Send-Email -subject "Erreur de numéro" -body "Taille du numéro erroné"
        $phoneForm.Close()
    })
    
    $letterErrorButton = New-Object System.Windows.Forms.Button
    $letterErrorButton.Text = "Lettre dans le numéro"
    $letterErrorButton.Location = New-Object System.Drawing.Point(50, 100)
    $letterErrorButton.Size = New-Object System.Drawing.Size(200, 30)
    $letterErrorButton.Add_Click({
        Send-Email -subject "Erreur de numéro" -body "Lettre dans le numéro"
        $phoneForm.Close()
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
        $phoneForm.Close()
    })
    
    $phoneForm.Controls.Add($absentButton)
    $phoneForm.Controls.Add($sizeErrorButton)
    $phoneForm.Controls.Add($letterErrorButton)
    $phoneForm.Controls.Add($otherButton)
    $phoneForm.ShowDialog()
})

$form.Controls.Add($buttonReportProblem)
$form.Controls.Add($buttonPhoneError)

[void] $form.ShowDialog()
