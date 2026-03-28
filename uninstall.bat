@echo off
REM Vocaloid 6 Chinese Pack - Windows 卸載腳本

echo 🔄 正在恢復原始文件...

REM 找到最新備份
for /f "delims=" %%a in ('dir /b /ad /o-d "%USERPROFILE%\.vocaloid6_backup\" 2^>nul') do (
    set "BACKUP_DIR=%USERPROFILE%\.vocaloid6_backup\%%a"
    goto :found
)

echo ❌ 找不到備份文件
exit /b 1

:found
echo 📁 使用備份: %BACKUP_DIR%

REM 恢復文件
set "VOCALOID_PATH=C:\Program Files\VOCALOID6"
if not exist "%VOCALOID_PATH%" (
    set "VOCALOID_PATH=C:\Program Files (x86)\VOCALOID6"
)

xcopy /E /I /Y "%BACKUP_DIR%\resources" "%VOCALOID_PATH%\resources" >nul 2>&1

echo ✅ 恢復完成！
echo 📝 請重啟 Vocaloid 6
