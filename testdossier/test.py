import subprocess
import os

# Chemin vers le script PowerShell
ps_script_path = os.path.abspath("HelloWorld.ps1")

# Utiliser pwsh pour exécuter le script PowerShell
process = subprocess.Popen(["pwsh", ps_script_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = process.communicate()

# Afficher les résultats
print("Standard Output:", stdout.decode())
print("Standard Error:", stderr.decode())
