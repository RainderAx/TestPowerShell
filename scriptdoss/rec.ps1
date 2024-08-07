# Using the filter to find the user
$user = Get-ADUser -Filter { Name -like "*Sophie.BEAUDOUIN HUBIERE*" }

# Check if the user object was found
if ($user) {
    $Users_OH = $user.SamAccountName
    Write-Host $Users_OH
} else {
    Write-Host "User not found"
}
