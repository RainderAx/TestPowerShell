# Variables contenant le prénom et le nom de l'utilisateur
$prenom = "Alexis"
$nom = "JOSEPH"

# Récupérer l'utilisateur correspondant au prénom et nom fournis
$user = Get-ADUser -Filter "GivenName -like '$($prenom)*' -and Surname -like '$($nom)*'" -Properties *

# Vérifier si un utilisateur a été trouvé
if ($user) {
    # Afficher toutes les propriétés de l'utilisateur
    $user | Select-Object *
} else {
    Write-Host "Utilisateur non trouvé"
}


$prenom = "Alexis"
$nom = "JOSEPH"
 
 $test=(Get-ADUser -Filter "samAccountName -like '$($prenom)*$($nom)*'")-Properties* | UserPrincipalName