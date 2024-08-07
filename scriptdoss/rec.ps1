# Variables pour le filtre
$prenom = "Ludovic"
$nom = "DOS-SANTOS"

# Utilisation de la commande Get-ADUser avec le filtre approprié
$filter = "samAccountName -like '*$($prenom)*$($nom)*'"
$uD = (Get-ADUser -Filter $filter).SamAccountName

# Vérification si $uD n'est pas null ou vide
if ($null -ne $uD -and $uD -ne "") {
    # Création de la chaîne de données utilisateur
    $userData = "$Global:bur2,$uD"

    # Écriture des données dans le fichier
    $userData | Out-File -FilePath "C:\Scripts\Alexis\test_pour_script2\U_$uD.txt"
} else {
    Write-Host "Aucun utilisateur trouvé avec le nom $prenom $nom"
}
