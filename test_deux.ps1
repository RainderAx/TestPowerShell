# Importer le module Active Directory
Import-Module ActiveDirectory

# Importer le module Windows 
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing


#dans l'interface demandé le user
AskUser = input(printf("Le nom de l'urilisateur"))

# Vérifier si le fichier d'entrée existe
if (-Not (Test-Path $inputFile)) {
    Write-Host "Le user n'existe pas dans l'AD : $inputFile"
    exit
}

#demandé le nouveau bureau

# Modifier les propriétés d'un user existant
Set-ADUser -Identity AskUser `
           -Numero_de_bureau  "New York" `
           
           
