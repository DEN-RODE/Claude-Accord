@echo off
chcp 65001 >nul
title A Corps - Accordeur et Solfege
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"$ErrorActionPreference='Stop';" ^
"$f=Join-Path '%~dp0' 'A-Corps.html';" ^
"if(-not (Test-Path -LiteralPath $f)){ Write-Host 'Fichier A-Corps.html introuvable a cote de ce lanceur.'; Read-Host 'Appuyez sur Entree'; exit };" ^
"$body=[IO.File]::ReadAllBytes($f);" ^
"$port=8731; $srv=$null;" ^
"for($p=$port;$p -lt $port+30;$p++){ try{ $srv=New-Object System.Net.Sockets.TcpListener([System.Net.IPAddress]::Loopback,$p); $srv.Start(); $port=$p; break }catch{ $srv=$null } };" ^
"if(-not $srv){ Write-Host 'Aucun port disponible.'; Read-Host; exit };" ^
"$url='http://127.0.0.1:'+$port+'/';" ^
"Write-Host ''; Write-Host ('   A Corps est lance !   '+$url); Write-Host '   Laissez cette fenetre ouverte. Fermez-la pour quitter.'; Write-Host '';" ^
"Start-Process $url;" ^
"$nl=[char]13+[char]10;" ^
"$hdr=[Text.Encoding]::ASCII.GetBytes('HTTP/1.1 200 OK'+$nl+'Content-Type: text/html; charset=utf-8'+$nl+'Content-Length: '+$body.Length+$nl+'Cache-Control: no-store'+$nl+'Connection: close'+$nl+$nl);" ^
"while($true){ try{ $c=$srv.AcceptTcpClient(); $ns=$c.GetStream(); $ns.ReadTimeout=250; $tmp=New-Object byte[] 4096; try{ $ns.Read($tmp,0,4096)|Out-Null }catch{}; $ns.Write($hdr,0,$hdr.Length); $ns.Write($body,0,$body.Length); $ns.Flush(); $ns.Close(); $c.Close() }catch{} }"
