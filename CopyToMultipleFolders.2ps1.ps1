$folders = Get-ChildItem "C:\Users\marko.charqueno\Desktop\Latitude 7390" -Directory -Recurse | Select-Object -Property PSPath
#| Export-Csv -Path "C:\Users\marko.charqueno\Desktop\Test\Test.csv" -Force

foreach ($folder in $folders.Name)
{
    Copy-Item -Path "C:\TempCSV\Test\Thing.txt" -Destination "C:\Users\Marko.Charqueno\Desktop\Latitude 7390\$folder" -Force
}