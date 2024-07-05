

# Ajouter un événement au bouton pour afficher la sélection avec switch
$button.Add_Click({
    $selectedOption = $comboBox.SelectedItem

    switch ($selectedOption) {
        "Option 1" { [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : Option 1") }
        "Option 2" { [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : Option 2") }
        "Option 3" { [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : Option 3") }
        "Option 4" { [System.Windows.Forms.MessageBox]::Show("Vous avez sélectionné : Option 4") }
        default { [System.Windows.Forms.MessageBox]::Show("Option non reconnue") }
    }
})

