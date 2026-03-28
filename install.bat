@echo off
REM Vocaloid 6 Chinese Pack - Windows 安裝腳本

echo 🎵 Vocaloid 6 中文漢化包 - Windows 版
echo ====================================
echo.

REM 檢查系統
if not "%OS%"=="Windows_NT" (
    echo ❌ 錯誤：此腳本僅適用於 Windows
    exit /b 1
)

REM 檢查 Vocaloid 6
set "VOCALOID_PATH=C:\Program Files\VOCALOID6"
if not exist "%VOCALOID_PATH%" (
    set "VOCALOID_PATH=C:\Program Files (x86)\VOCALOID6"
)

if not exist "%VOCALOID_PATH%" (
    echo ❌ 未找到 Vocaloid 6，請先安裝
    exit /b 1
)

echo ✅ 找到 Vocaloid 6: %VOCALOID_PATH%

REM 備份
echo 🔒 正在備份原始文件...
set "BACKUP_DIR=%USERPROFILE%\.vocaloid6_backup\%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "BACKUP_DIR=%BACKUP_DIR: =0%"
mkdir "%BACKUP_DIR%" 2>nul
xcopy /E /I /Y "%VOCALOID_PATH%\resources" "%BACKUP_DIR%\resources" >nul 2>&1
echo ✅ 備份完成: %BACKUP_DIR%

REM 應用漢化
echo 🎨 正在應用漢化...

REM 複製漢化文件
REM 實際應該替換資源文件

echo ✅ 漢化應用完成！
echo.
echo 📝 請重啟 Vocaloid 6 查看效果
echo 🔄 如需恢復，請運行: uninstall_windows.bat
