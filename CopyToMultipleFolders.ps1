<#
$folders = Get-ChildItem "\\adapsccm01\Drivers$\DriverPackages\Dell\Latitude\Latitude 7390" -Directory -Recurse 
foreach ($folder in $folders.Name) {
Copy-Item -Path "C:\Users\marko.charqueno\Desktop\Test\Latitude 7390.txt" -Destination "\\adapsccm01\Drivers$\DriverPackages\Dell\Latitude\Latitude 7390\$folders" -Force -WhatIf
}
#>

<#
 $source="C:\Users\marko.charqueno\Desktop\Test\Latitude 7390.txt"
 $target="\\adapsccm01\Drivers`$\DriverPackages\Dell\Latitude\Latitude 7390"

 
 foreach ($directory in $(get-childitem -Directory -Recurse $target).Name)
  {
  $targetpath= join-path -path $target -childpath $directory
  copy-item -path $source -Destination $targetpath -WhatIf
  }
  #>

Get-ChildItem "\\adapsccm01\Drivers$\DriverPackages\Dell\Latitude\Latitude 7390" -Directory -Recurse | Export-Csv -Path "C:\Users\marko.charqueno\Desktop\Test" -Force