@echo off
chcp 65001 >nul
title Construction de A-Corps.exe
echo.
echo  ==================================================
echo    Construction de l'executable A-Corps.exe
echo  ==================================================
echo.
setlocal enabledelayedexpansion
set "CSC="
for /d %%D in ("%WINDIR%\Microsoft.NET\Framework64\v4*") do if exist "%%D\csc.exe" set "CSC=%%D\csc.exe"
if not defined CSC for /d %%D in ("%WINDIR%\Microsoft.NET\Framework\v4*") do if exist "%%D\csc.exe" set "CSC=%%D\csc.exe"

if not defined CSC (
  echo  [X] Compilateur .NET introuvable sur ce PC.
  echo.
  echo      Pas de probleme : lancez plutot "A-Corps.bat"
  echo      qui ne necessite aucune compilation.
  echo.
  pause
  exit /b 1
)

echo  Compilateur trouve :
echo    !CSC!
echo.
echo  Compilation en cours...
"!CSC!" /nologo /optimize+ /target:exe /out:"%~dp0A-Corps.exe" "%~dp0A-Corps.cs"

if exist "%~dp0A-Corps.exe" (
  echo.
  echo  [OK] Termine ! "A-Corps.exe" a ete cree dans ce dossier.
  echo       Double-cliquez sur A-Corps.exe pour lancer l'application.
  echo.
) else (
  echo.
  echo  [X] La compilation a echoue. Utilisez "A-Corps.bat" a la place.
  echo.
)
pause
