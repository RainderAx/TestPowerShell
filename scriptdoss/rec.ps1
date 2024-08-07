$Users_OH = (Get-ADUser -Identity "Sophie.BEAUDOUIN HUBIERE" –Properties * ).SamAccountName

Write-Host $Users_OH

Get-ADUser : Impossible de trouver un objet avec l’identité « Sophie.BEAUDOUIN HUBIERE » sous : « DC=cabinet,DC=local ».
Au caractère Ligne:2 : 14
+ ... Users_OH = (Get-ADUser -Identity "Sophie.BEAUDOUIN HUBIERE" –Properti ...
+                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (Sophie.BEAUDOUIN HUBIERE:ADUser) [Get-ADUser], ADIdentityNotFoundException
    + FullyQualifiedErrorId : ActiveDirectoryCmdlet:Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException,Microsoft.ActiveDirectory.Management.Commands.GetADUser