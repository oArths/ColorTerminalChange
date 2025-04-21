@echo off
setlocal EnableDelayedExpansion

:: Permitir execução de scripts
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"

:: Detectar versão do PowerShell
for /f "delims=" %%v in ('powershell -NoProfile -Command "$PSVersionTable.PSVersion.Major"') do set "PS_VER=%%v"

:: Definir caminho do perfil
if %PS_VER% GEQ 7 (
    set "PROFILE=%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
) else (
    set "PROFILE=%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
)

:: Criar o arquivo se não existir
if not exist "%PROFILE%" (
    echo # Perfil PowerShell > "%PROFILE%"
    echo Adicionando cor verde ao perfil...
    echo ^$Host.UI.RawUI.ForegroundColor = 'Green' >> "%PROFILE%"
    echo Clear-Host >> "%PROFILE%"
)


:: Fecha o terminal atual (PowerShell e CMD)
taskkill /f /im powershell.exe >nul 2>&1
taskkill /f /im cmd.exe >nul 2>&1


endlocal
