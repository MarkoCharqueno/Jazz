﻿Get-ChildItem -Path '\\adapsccm01\drivers$\DriverPackages\Dell\Latitude\Latitude5401\*' -Recurse -Include *txt | Rename-Item -NewName { $_.Name.replace("RenameMe","Latitude 5041") }