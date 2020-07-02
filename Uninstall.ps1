Function Uninstall
{
Get-Package -Name "*Office 16 Click to Run*" | Uninstall-Package -Force -ErrorAction SilentlyContinue
LogWrite -LogSuccess "Office 16 Click to Run discovered and uninstalled" -LogFail "Office 16 Click to Run did not exist or failed to be uninstalled"


}
#
#Make this a thing later
#
#