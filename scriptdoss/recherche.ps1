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
