Set-ADUser : Impossible de valider l'argument sur le paramètre «Identity». L’argument est Null. Spécifiez une valeur valide pour 
l’argument, puis réessayez.
Au caractère Ligne:2 : 22
+ Set-ADUser -Identity $Utilis -Office '1234'
+                      ~~~~~~~
    + CategoryInfo          : InvalidData : (:) [Set-ADUser], ParameterBindingValidationException
    + FullyQualifiedErrorId : ParameterArgumentValidationError,Microsoft.ActiveDirectory.Management.Commands.SetADUser


$Utilis=(Get-ADUser -Filter "UserPrincipalName -like 'Alexis Joseph*'" -Properties *).SamAccountName
Set-ADUser -Identity $Utilis -Office '1234'