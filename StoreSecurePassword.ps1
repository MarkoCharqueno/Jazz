$credential = Get-Credential
$credential.Password | ConvertFrom-SecureString | Set-Content c:scriptsencrypted_password1.txt