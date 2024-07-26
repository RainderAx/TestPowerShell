####
####
##################################################################################################################################################################
#############################  Ce Script manipule des fichiers géénérés par autre script (description-ordinateur) lors de l'installation du PC ###################

#############################  Ce Script met à jour le champ description pc ######################################################################################

#############################  Ce script déplace le PC dans la bonne OU ###########################################################################################

#############################  Ce script supprime le pc du groupe "grp-ordinateurs-Stock_Tampon"  #################################################################

####################################################################################################################################################################
# ce script sera executé avec une tâche planifiée.
# Spécifiez le chemin du répertoire à traiter

$path = "C:\Scripts\Alexis\test_pour_script2 "
# Obtenez tous les fichiers dans le répertoire
 $Userfiler = Get-ChildItem $path
# répertoire de destination 
#variable modifiée
$emplacement = "C:\Scripts\Alexis\test_pour_script2\Deuxième_Dossier"
# réinitilaisation de la variable
#variable modifiée
$file = $null
# variable pour ignorer toutes les erreurs et ne pas les afficher
$ErrorActionPreference= 'silentlycontinue'
# Pour chaque fichier, affichez le contenu

#variable modifiée
foreach ($file in $Userfiler) {  
    Get-Content $path\$file | ForEach-Object {
            
        # Séparez le contenu avec le délimiteur ","

        $Nom= $_.Split(",")[0]
        $Prenom = $_.Split(",")[1]
        $Bureau = $_.Split(",")[2]
        $Login = $_.Split(",")[3]
        $Telephone = $_.Split(",")[4]

# les variables nécessaires au fonctionnement du script

#variable modifiée
$Utilis = (Get-ADUser -Filter "UserPrincipalName -like '$Login*'" -Properties *).SamAccountName

$Ou_Pc = "OU=$Cabinet,OU=ordinateurs,OU=infra,DC=cabinet,DC=local"

#
######################## manipulation de l'objet.
#

###ajout
### Modifier le bureau
Set-ADUser -Identity $Utilis -Office '$Bureau'


if ($Cabinet -like "OH") {

    $Users_OH = (Get-ADUser -Identity "$Prenom.$Nom" –Properties * ).department

    $Cab_OH = $Users_OH.split("/")[1]

    $Cab_OH_0 = $Users_OH.split("/")[0]

    $Description_Pc = "$Nom $Prenom Bur: $Bureau Tel: $tel $Cab_OH"

    $Grp_Pc = "grp-ordinateurs-$Cab_OH"

    $Ou_Pc = "OU=$Cab_OH, OU=$Cab_OH_0,OU=OH,OU=ordinateurs,OU=infra,DC=cabinet,DC=local"


    Manage-Computer -Computer $Computer  -Description_Pc $Description_Pc -Grp_Pc $Grp_Pc -Ou_Pc $Ou_Pc 

}
####

#
# verifier de l'envoie de notification email
#

#ajout
$second_mail = "administrateurs.psnsm@cabinet.local"

$Sujet = "Deplacement $Nom $Prenom au bureau $Bureau"

$SmtpServer = ""

$corps = @"

    Bonjour,

    Le bureau de $Nom $Prenom est maintenant en $Bureau         

"@
#####

if ($Cabinet -like "SETI4") {

            $SET4 = "set4"

            $Grp_Pc = "grp-ordinateurs-set4"

            $Description_Pc = "$Nom $Prenom Bur: $Bureau Tel: $SET4"

            $Ou_Pc ="OU=seti4,OU=ordinateurs,OU=infra,DC=cabinet,DC=local"


            Manage-Computer -Computer $Computer  -Description_Pc $Description_Pc -Grp_Pc $Grp_Pc -Ou_Pc $Ou_Pc
     
            }

             elseif ($Cabinet -match "DSP") {

                     $DSP = "psnsm"

                     $Description_Pc = "$Nom $Prenom Bur: $Bureau Tel: $tel $DSP"

                     $Grp_Pc = "grp-ordinateurs-psnsm"
 
                     $Ou_Pc ="OU=psnsm,OU=ordinateurs,OU=infra,DC=cabinet,DC=local"

             
                     Manage-Computer -Computer $Computer  -Description_Pc $Description_Pc -Grp_Pc $Grp_Pc -Ou_Pc $Ou_Pc
      
                        } else {

                         Manage-Computer -Computer $Computer  -Description_Pc $Description_Pc -Grp_Pc $Grp_Pc -Ou_Pc $Ou_Pc


                        }
 

        }

        #
        ########################### Mail de notification

        Send-MailMessage -From $mail -To $mail -Subject $Sujet  -Body $body -SmtpServer $SmtpServer -port 587 -Encoding unicode

         #
         ############# une fois la modification est à jour, la vérification du groupe ordinateur et d'OU ordinateur, le fichier serait  deplacé dans le dossier Archives
         #

        Move-Item -Path "$chemin\$fichier"  -Destination $destination


        #ajout
        Send-MailMessage -From $second_mail -To $second_mail -Subject $Subject  -Body $corps -SmtpServer $SmtpServer -port 587 -Encoding unicode

        ###ajout
        Move-Item -Path "$path\$file"  -Destination $emplacement

 }