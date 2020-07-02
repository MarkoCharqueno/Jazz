$cmdkeys = cmdkey /list
$leggenkeys = $cmdkeys | Where-Object {$_ -match "LegacyGeneric"}
foreach ($leggenkey in $leggenkeys) {
    $keytodelete = $leggenkey.Remove(0,12)
    cmdkey /delete:$keytodelete

}