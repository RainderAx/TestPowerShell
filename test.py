import subprocess

# Commande PowerShell à exécuter
command = "Get-Process"

# Exécution de la commande PowerShell
process = subprocess.Popen(["powershell", "-Command", command], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

# Récupération de la sortie et des erreurs
output, error = process.communicate()

print("Output:")
print(output.decode())
print("Error:")
print(error.decode())
