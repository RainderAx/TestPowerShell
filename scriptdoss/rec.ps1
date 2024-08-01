# Spécifiez le chemin du répertoire à traiter
$chemin = "\\cabinet.local\partages\support-informatique\Info_Computer\Description-PC"

# Obtenez tous les fichiers dans le répertoire
$Pcfiler = Get-ChildItem $chemin

# Répertoire de destination
$destination = "\\cabinet.local\partages\support-informatique\Info_Computer\Archives"

# Initialisation de la variable
$fichier = $null

# Variable pour ignorer toutes les erreurs et ne pas les afficher
$ErrorActionPreference= 'silentlycontinue'

# Fonction pour gérer les ordinateurs
function Manage-Computer {
    param(
        [string]$Computer,
        [string]$Description_Pc,
        [string]$Grp_Pc,
        [string]$Ou_Pc
    )

    # Description Ordinateur
    Set-ADComputer -Identity $Computer -Description $Description_Pc -Confirm:$false
    
    # Rajout de l'ordinateur dans le groupe correspondant
    Add-AdGroupMember -Identity $Grp_Pc -Members $Computer -Confirm:$false

    # Suppression de l'ordinateur du "groupe grp-ordinateurs-Stock_Tampon"
    Remove-ADGroupMember -Identity "grp-ordinateurs-Stock_Tampon" -Members $Computer -Confirm:$false

    # Déplacement de l'ordinateur dans la bonne OU correspondante
    Move-ADObject -Identity $Computer -TargetPath $Ou_Pc -Confirm:$false
}

# Pour chaque fichier, affichez le contenu
foreach ($fichier in $Pcfiler) {
    $filePath = "$chemin\$fichier"

    if ($fichier.Name -match "^P-PC\d{3}\w{3}_\s\w+\.txt$") {
        # Traitement pour le premier type de fichier (numéro de série du PC suivi du nom de famille)
        Get-Content $filePath | ForEach-Object {
            $Nom = $_.Split(",")[0]
            $Prenom = $_.Split(",")[1]
            $Bureau = $_.Split(",")[2]
            $Tel = $_.Split(",")[3]
            $Cabinet = $_.Split(",")[4]
            $Pc = $_.Split(",")[5]

            # Variables nécessaires au fonctionnement du script
            $Computer = (Get-ADComputer -Identity $Pc -Properties *).DistinguishedName
            $grp_User = "grp-utilisateurs-$Cabinet"
            $Grp_Pc = "grp-ordinateurs-$Cabinet"
            $Ou_Pc = "OU=$Cabinet,OU=ordinateurs,OU=infra,DC=cabinet,DC=local"
            $PcMemberOf = (Get-ADComputer -Identity $Pc -Properties *).memberof
            $Description_Pc = "$Nom $Prenom Bur: $Bureau Tel: $Tel $Cabinet"

            if ($Cabinet -like "OH") {
                $Users_OH = (Get-ADUser -Identity "$Prenom.$Nom" –Properties * ).department
                $Cab_OH = $Users_OH.split("/")[1]
                $Cab_OH_0 = $Users_OH.split("/")[0]
                $Description_Pc = "$Nom $Prenom Bur: $Bureau Tel: $Tel $Cab_OH"
                $Grp_Pc = "grp-ordinateurs-$Cab_OH"
                $Ou_Pc = "OU=$Cab_OH, OU=$Cab_OH_0,OU=OH,OU=ordinateurs,OU=infra,DC=cabinet,DC=local"
            } elseif ($Cabinet -like "SETI4") {
                $SET4 = "set4"
                $Grp_Pc = "grp-ordinateurs-set4"
                $Description_Pc = "$Nom $Prenom Bur: $Bureau Tel: $SET4"
                $Ou_Pc = "OU=seti4,OU=ordinateurs,OU=infra,DC=cabinet,DC=local"
            } elseif ($Cabinet -match "DSP") {
                $DSP = "psnsm"
                $Description_Pc = "$Nom $Prenom Bur: $Bureau Tel: $Tel $DSP"
                $Grp_Pc = "grp-ordinateurs-psnsm"
                $Ou_Pc = "OU=psnsm,OU=ordinateurs,OU=infra,DC=cabinet,DC=local"
            }

            Manage-Computer -Computer $Computer -Description_Pc $Description_Pc -Grp_Pc $Grp_Pc -Ou_Pc $Ou_Pc
        }
    } elseif ($fichier.Name -match "^\w+\.\w+(\.cab)?\.txt$") {
        # Traitement pour le deuxième type de fichier (prénom.nom ou prénom.nom.cab)
        Get-Content $filePath | ForEach-Object {
            # Exemple de traitement, à adapter selon vos besoins spécifiques
            $Prenom = $_.Split(",")[0]
            $Nom = $_.Split(",")[1]
            $Bureau = $_.Split(",")[2]
            $Tel = $_.Split(",")[3]
            $Cabinet = $_.Split(",")[4]
            $Pc = $_.Split(",")[5]

            # Variables nécessaires au fonctionnement du script
            $Computer = (Get-ADComputer -Identity $Pc -Properties *).DistinguishedName
            $grp_User = "grp-utilisateurs-$Cabinet"
            $Grp_Pc = "grp-ordinateurs-$Cabinet"
            $Ou_Pc = "OU=$Cabinet,OU=ordinateurs,OU=infra,DC=cabinet,DC=local"
            $Description_Pc = "$Prenom $Nom Bur: $Bureau Tel: $Tel $Cabinet"

            Manage-Computer -Computer $Computer -Description_Pc $Description_Pc -Grp_Pc $Grp_Pc -Ou_Pc $Ou_Pc
        }
    }

    # Envoi de l'email de notification
    Send-MailMessage -From $mail -To $mail -Subject $Subject -Body $body -SmtpServer $SmtpServer -port 587 -Encoding unicode

    # Déplacement du fichier traité vers le dossier Archives
    Move-Item -Path $filePath -Destination $destination
}