# Set the user's photo
Set-UserPhoto -Identity "user@domain.com" -PictureData ([System.IO.File]::ReadAllBytes("C:\temp\$user.jpg")) -Preview -Confirm:$false

# Save the new photo
Set-UserPhoto -Identity "user@domain.com" -Save -Confirm:$false

# Confirm it was applied
Get-UserPhoto -Identity "user@domain.com"
