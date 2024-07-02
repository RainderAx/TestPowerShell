#Set-ADUser : Droits d’accès insuffisants pour effectuer cette opération
Au caractère Ligne:8 : 1
+ Set-ADUser -Identity $user -Office '$buro'
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (alexis.joseph.cab:ADUser) [Set-ADUser], ADException
    + FullyQualifiedErrorId : ActiveDirectoryServer:8344,Microsoft.ActiveDirectory.Management.Commands.SetADUser
##

$poire = "alexis.joseph"

$buro = 6013

$user = (Get-ADUser -Filter "UserPrincipalName -like '$poire*'" -Properties *).SamAccountName

Set-ADUser -Identity $user -Office '$buro'