Param(
    [string]$piusername = 'pi',
    [string]$pihostname = '192.168.99.36'
)
$ErrorActionPreference = 'Stop'
cd $PSScriptRoot

$timestamp = [DateTime]::Now.ToString('yyyyMMdd\THHmmss')
Set-Content -Value $timestamp -Path $(Join-Path -Path $PSScriptRoot -ChildPath "version.txt") -Encoding UTF8 -NoNewline -Force

$ssh_user = $piusername + '@' + $pihostname


& scp.exe -r "$($piusername)@$($pihostname)`:/home/pi/IoT3/" ".\"
Get-ChildItem -Path ".\IoT3" | %{
    Move-Item -Path $_.FullName -Destination ".\$($_.Name)" -Force
}

Remove-Item -Path ".\IoT3" -Force -Recurse
&git add -A
&git commit -m "auto-$($timestamp)"
&git push

#@ECHO OFF
#cd %~dp0
#
#FOR /F "tokens=* USEBACKQ" %%F IN (`powershell -Command "return [DateTime]::Now.ToString('yyyyMMdd\THHmmss')"`) DO (
#SET timestamp=%%F
#)
#
#SET piusername=pi
#SET pihostname=192.168.99.36
#
#echo %timestamp% > ".\version.txt"
#
#scp -r %piusername%@%pihostname%:/home/pi/IoT3/ .\
#:: move /y IoT3 .
#:: git add -A && git commit -m "auto-%timestamp%" && git push
#pause