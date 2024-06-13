# Définir le chemin du fichier d'entrée et de sortie
$inputFile = "\workspaces\codespaces-blank\testdossier\input.txt"
$outputFile = "\workspaces\codespaces-blank\testdossier\output.txt"

# Vérifier si le fichier d'entrée existe
if (-Not (Test-Path $inputFile)) {
    Write-Host "Le fichier d'entrée n'existe pas : $inputFile"
    exit
}

# Lire toutes les lignes du fichier d'entrée
$lines = Get-Content -Path $inputFile

# Créer un tableau pour stocker les lignes converties
$convertedLines = @()

# Traiter chaque ligne
foreach ($line in $lines) {
    # Convertir la ligne en majuscules
    $convertedLine = $line.ToUpper()
    # Ajouter la ligne convertie au tableau
    $convertedLines += $convertedLine
}

# Écrire les lignes converties dans le fichier de sortie
Set-Content -Path $outputFile -Value $convertedLines

# Afficher un message de succès
Write-Host "Les données ont été converties et écrites dans le fichier : $outputFile"
