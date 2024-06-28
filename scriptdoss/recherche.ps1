
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
    [String]$Login=$TextBoxLogin.Text().Trim(' ')
    ###
    $donnees = "$Nom,$Prenom,$Bureau,$Telephone,$Service"
    $donnees | Out-File "\\C:\Scripts\Alexis\$Login _ $Nom.txt"
 
    #ajout
    New-Item -Path "C:\Scripts\Alexis\$Login.txt" -ItemType File -Force
    $userData = "$Bureau,Login"
    $userData | Out-File -FilePath "C:\Scripts\Alexis\$Login.txt"
        
        

	{
		[String]$Description = "$Nom $Prenom Bur: $Bureau Tel: $Telephone $Service"
	}
	
	
	
	

	$LabelMessage.Forecolor = 'Green'
	$LabelMessage.text = "La modfication de $Poste est OK"

    [System.Windows.Forms.MessageBox]::Show("Fichier créé avec succès :")
})