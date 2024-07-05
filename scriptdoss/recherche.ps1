$valider.Add_Click(
    Write-Output "Nom du Serveur AD : $($domaine.HostName)"
)

Impossible de convertir l'argument «value» (valeur «OK») de «add_Click» en type «System.EventHandler»: «Impossible de 
convertir la valeur «OK» en type «System.EventHandler». Erreur: «Cast non valide de 'System.Windows.Forms.DialogResult' en 
'System.EventHandler'.»»
Au caractère Ligne:117 : 1
+ $valider.Add_Click(
+ ~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [], MethodException
    + FullyQualifiedErrorId : MethodArgumentConversionInvalidCastArgument