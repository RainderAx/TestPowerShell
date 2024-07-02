$poire = "alex"

Get-ADUser -Filter "samAccountName -like '$poire*'"
