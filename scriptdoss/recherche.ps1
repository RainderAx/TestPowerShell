$button_generer.Add_Click({

    
	if (($Global:VerifPrenom -eq 0) -or ($Global:VerifNom -eq 0) -or ($Global:VerifBureau -eq 0)) {
		return
	}


	[String]$Bureau=$TextBureau.Get_text().Trim(' ')
	[String]$Prenom=$TextBoxPrenom.Get_text().Trim(' ')
	[String]$Nom=$TextBoxNom.Get_text().Trim(' ')
	[String]$Service=$ComboBoxService.Get_text().Trim(' ')
	[String]$Telephone=$TextTelephone.Get_text().Trim(' ')
	[String]$Poste=$ComboBoxPoste.Get_text().Trim(' ') 
    
    #ajout
    [String]$Login=$TextBoxLogin.Text.Trim(' ')
    ###
    New-Item -Path "C:\Scripts\Alexis\$Nom.txt" -ItemType File -Force
    $donnees = "$Nom,$Prenom,$Bureau,$Telephone,$Service"
    $donnees | Out-File  -FilePath "C:\Scripts\Alexis\$Nom.txt"
 
    #ajout
    New-Item -Path "C:\Scripts\Alexis\$Login.txt" -ItemType File -Force
    $userData = "$Bureau,$Login"
    $userData | Out-File -FilePath "C:\Scripts\Alexis\$Login.txt"
    ####  
    
    ###ajout vérifie si le numéro de téléphone n'est pas renseigné  
        if ([string]::IsNullOrEmpty($Telephone)) {
            Write-Output "Gojo > Jogo"
        }