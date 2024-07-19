$button_generer.Add_Click({

    if (-not ($Global:VerifPrenom) -or -not ($Global:VerifNom) -or -not ($Global:VerifTelephone)) {
        [System.Windows.Forms.MessageBox]::Show("Please ensure all fields are correctly filled out.")
        return
    }
