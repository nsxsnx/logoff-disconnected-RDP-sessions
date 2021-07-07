CLS
$RD = Get-RDUserSession -ConnectionBroker Ariadna.mures.global -CollectionName "YOU_COLLECTION_HERE"
foreach ($item in $RD) 
{
    $UsessionID = $item.UnifiedSessionId -as [int]
    $sessionID = $item.SessionId -as [int]
    if ($item.SessionState -eq "STATE_DISCONNECTED" -and $item.DisconnectTime -ne $null -and $item.UnifiedSessionId -ne $null)
    {
        #if ($item.UserName -ne "testuser")  {continue}
        write-host $Item.UserName " " -ForegroundColor "magenta" -NoNewline
        write-host  $item.SessionState "since" $item.DisconnectTime -NoNewline
        write-host " Unified SId:" $UsessionID "User SId:" $sessionID -ForegroundColor "darkcyan" -NoNewline
        write-host " Host" $item.ServerName  "on" $item.HostServer -ForegroundColor "cyan"
        $TimeDiff = New-TimeSpan -start $item.DisconnectTime -end (Get-Date)
        if ($TimeDiff.Minutes -lt 5) 
        {
            write-host "Disconnected for less than 5 minutes" -ForegroundColor "Green"
            continue
        }
        #Invoke-RDUserLogoff -HostServer $item.HostServer -UnifiedSessionID $UsessionID -Force -verbose #-erroraction 'silentlycontinue'
        write-host "killed" -ForegroundColor "red"
        }
}
