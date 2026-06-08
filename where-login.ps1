$searcher = New-Object System.DirectoryServices.DirectorySearcher
$searcher.SearchRoot = New-Object System.DirectoryServices.DirectoryEntry("")

$target = $Args[0]
# Find the user's last logon
$searcher.Filter = "(cn=$target)"
# Note: each property is still a ResultPropertyCollection so get
# the first item
$res = $searcher.FindOne()
if ($res.Properties.lastlogontimestamp.Length -eq 0) {
    echo "Could not find lastLogonTimestamp for $target"
    exit
}
$lastlogon = $res.Properties.lastlogontimestamp[0]
$lastlogondt = ([datetime]::FromFileTime($lastlogon))

# TODO: make this an arg/flag please
$RANGE = [timespan]::new(4, 0, 0) # 4 hours appears to work best

# TODO: AddHours, AddMinutes, etc methods exist
# Set a minimum lastlogontimestamp
$minimum = $lastlogondt.Subtract($RANGE)
$minimum = $minimum.ToFileTime()

# Note: When first writing this I was lazy and decided to look 4 hours in the future too,
# but I just realised that's kind of silly. Keeping this here in case peeking into the future
# turns out to be helpful somehow 
#$maximum = $lastlogondt.Add($RANGE)
#$maximum = $maximum.ToFileTime()

# Now find anything else where lastlogontimestamp is within the range
$searcher.Filter = "(&(objectClass=computer)(lastLogonTimestamp>=$minimum)(lastLogonTimestamp<=$lastlogon))"
$results = $searcher.FindAll()

$objs = foreach ($result in $results) {
    $props = $result.Properties
    [PSCustomObject]@{
        Name = $props.cn[0]
        Logon = [datetime]::FromFileTime($props.lastlogontimestamp[0])
        UserLogon = $lastlogondt # just for easy comparison
    }
}
$objs | Format-Table
