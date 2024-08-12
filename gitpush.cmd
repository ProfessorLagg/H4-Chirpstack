@ECHO OFF
cd %~dp0

FOR /F "tokens=* USEBACKQ" %%F IN (`powershell -Command "return [DateTime]::Now.ToString('yyyyMMdd\THHmmss')"`) DO (
SET timestamp=%%F
)

SET pihostname=192.168.99.36

echo %timestamp% > ".\version.txt"

git add -A && git commit -m "auto-pre-%timestamp%" && git push
scp -r pi@%pihostname%:/home/pi/IoT3/ .\ && xcopy .\IoT3 .\ /h /e /y /f && rmdir .\IoT3 /s /q
git add -A && git commit -m "auto-post-%timestamp%" && git push
pause