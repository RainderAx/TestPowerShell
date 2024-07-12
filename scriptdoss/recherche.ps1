# Récupérer les utilisateurs correspondant au filtre
$users = Get-ADUser -Filter "UserPrincipalName -like 'Alexis Joseph*'" -Properties SamAccountName

# Vérifier si des utilisateurs ont été trouvés
if ($users) {
    # Si plusieurs utilisateurs sont trouvés, afficher un message ou gérer en conséquence
    if ($users.Count -gt 1) {
        Write-Output "Attention: plusieurs utilisateurs trouvés."
        $users | ForEach-Object { 
            Set-ADUser -Identity $_.SamAccountName -Office '1234'
        }
    } else {
        # Si un seul utilisateur est trouvé, mettre à jour les propriétés
        Set-ADUser -Identity $users.SamAccountName -Office '1234'
    }
} else {
    Write-Output "Aucun utilisateur trouvé avec le filtre spécifié."
}


DistinguishedName : CN=JOSEPH Alexis,OU=PSNSM2,OU=PSNSM,OU=DSP,OU=cabinet,DC=cabinet,DC=local
Enabled           : True
GivenName         : Alexis
Name              : JOSEPH Alexis
ObjectClass       : user
ObjectGUID        : e5fd88ff-39d4-45d9-a120-861bc92da464
SamAccountName    : alexis.joseph.cab
SID               : S-1-5-21-1940544878-2514950346-2276345395-38703
Surname           : JOSEPH
UserPrincipalName : alexis.joseph.cab@i-carre.net

Set-ADUser : Droits d’accès insuffisants pour effectuer cette opération
Au caractère Ligne:14 : 9
+         Set-ADUser -Identity $users.SamAccountName -Office '1234'
+         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (alexis.joseph.cab:ADUser) [Set-ADUser], ADException
    + FullyQualifiedErrorId : ActiveDirectoryServer:8344,Microsoft.ActiveDirectory.Management.Commands.SetADUser
