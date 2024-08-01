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


$chemin = "\\cabinet.local\partages\support-informatique\Info_Computer\Description-PC"

# Obtenez tous les fichiers dans le répertoire

 $Pcfiler = Get-ChildItem $chemin



# répertoire de destination 

$destination = "\\cabinet.local\partages\support-informatique\Info_Computer\Archives"

# réinitilaisation de la variable

$fichier = $null


# variable pour ignorer toutes les erreurs et ne pas les afficher


$ErrorActionPreference= 'silentlycontinue'


# Pour chaque fichier, affichez le contenu


foreach ($fichier in $Pcfiler) {  

    Get-Content $chemin\$fichier | ForEach-Object {
            
        # Séparez le contenu avec le délimiteur ","

        $Nom= $_.Split(",")[0]

        $Prenom = $_.Split(",")[1]

        $Bureau = $_.Split(",")[2]

        $Tel = $_.Split(",")[3]

        $Cabinet = $_.Split(",")[4]

        $Pc = $_.Split(",")[5] 
    

# les variables nécessaires au fonctionnement du script

$Computer = (Get-ADComputer -Identity $Pc -Properties *).DistinguishedName

$grp_User = "grp-utilisateurs-$Cabinet"

$Grp_Pc = "grp-ordinateurs-$Cabinet"

$Ou_Pc = "OU=$Cabinet,OU=ordinateurs,OU=infra,DC=cabinet,DC=local"

$PcMemberOf = (Get-ADComputer -Identity $Pc -Properties *).memberof

$Description_Pc = "$Nom $Prenom Bur: $Bureau Tel: $tel $Cabinet"


#
# variable de l'envoie de notification email
#

$mail = "administrateurs.psnsm@cabinet.local"

$Subject = "Description Ordinateur $Pc"

$SmtpServer = "mail.cabinet.local"

$body = @"

 Bonjour,

 la description de l'ordinateur $Pc est faite.

 $PC est déplacé dans la bonne OU

 Cordialement,

 Service informatique.

"@

#
######################## manipulation de l'objet.
#


function Manage-Computer {

    param(

        [string]$Computer,

        [string]$Description_Pc,

        [string]$Grp_Pc,

        [string]$Ou_Pc
    )

    ############### Description Ordinateur

    Set-ADComputer -Identity $Computer -Description $Description_Pc -Confirm:$false
    
    ################ rajout de l'ordinateur dans le groupe correspondant

    Add-AdGroupMember -Identity $Grp_Pc -Members $Computer -Confirm:$false

    ############## suppression de l'ordinateur du "groupe grp-ordinateurs-Stock_Tampon"
    
    Remove-ADGroupMember -Identity "grp-ordinateurs-Stock_Tampon" -Members $Computer -Confirm:$false

    ############## déplacement de l'ordinateur dans la bonne OU correspondante
   
    Move-ADObject –Identity $Computer -TargetPath $Ou_Pc -Confirm:$false

}


if ($Cabinet -like "OH") {

$Users_OH = (Get-ADUser -Identity "$Prenom.$Nom" –Properties * ).department

$Cab_OH = $Users_OH.split("/")[1]

$Cab_OH_0 = $Users_OH.split("/")[0]

$Description_Pc = "$Nom $Prenom Bur: $Bureau Tel: $tel $Cab_OH"

$Grp_Pc = "grp-ordinateurs-$Cab_OH"

$Ou_Pc = "OU=$Cab_OH, OU=$Cab_OH_0,OU=OH,OU=ordinateurs,OU=infra,DC=cabinet,DC=local"


Manage-Computer -Computer $Computer  -Description_Pc $Description_Pc -Grp_Pc $Grp_Pc -Ou_Pc $Ou_Pc 

}

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

        Send-MailMessage -From $mail -To $mail -Subject $Subject  -Body $body -SmtpServer $SmtpServer -port 587 -Encoding unicode

         #
         ############# une fois la modification est à jour, la vérification du groupe ordinateur et d'OU ordinateur, le fichier serait  deplacé dans le dossier Archives
         #

        Move-Item -Path "$chemin\$fichier"  -Destination $destination
 }