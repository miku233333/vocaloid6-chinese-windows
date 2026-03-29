# VOCALOID6 漢化包安裝器 (Windows)
# 狀態：開發中（夜間開發補救項目）
# 作者：qibot
# 版本：1.0.0

param(
    [switch]$Uninstall,
    [string]$Language = "zh-TW",
    [switch]$NoBackup
)

$ErrorActionPreference = "Stop"

# VOCALOID6 默認安裝路徑
$VocaloidPath = "C:\Program Files\VOCALOID6"
$BackupPath = "$VocaloidPath\backup"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  VOCALOID6 漢化包安裝器 v1.0.0" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 檢查管理員權限
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "❌ 錯誤：請以管理員身份運行此腳本" -ForegroundColor Red
    Write-Host "   右鍵點擊 install.ps1 → 以管理員身份運行" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ 管理員權限檢查通過" -ForegroundColor Green

# 檢查 VOCALOID6 安裝路徑
if (-not (Test-Path $VocaloidPath)) {
    Write-Host "❌ 錯誤：未找到 VOCALOID6 安裝目錄" -ForegroundColor Red
    Write-Host "   預設路徑：$VocaloidPath" -ForegroundColor Yellow
    Write-Host "   請確認 VOCALOID6 已正確安裝" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ VOCALOID6 安裝目錄已找到：$VocaloidPath" -ForegroundColor Green

# 卸載模式
if ($Uninstall) {
    Write-Host ""
    Write-Host "🔄 開始還原 VOCALOID6 原始文件..." -ForegroundColor Yellow
    
    if (Test-Path $BackupPath) {
        Get-ChildItem $BackupPath | ForEach-Object {
            $target = Join-Path $VocaloidPath $_.Name
            Write-Host "   還原：$($_.Name)" -ForegroundColor Gray
            Copy-Item $_.FullName $target -Force
        }
        Write-Host "✅ 還原完成！" -ForegroundColor Green
    } else {
        Write-Host "⚠️ 未找到備份文件，無法還原" -ForegroundColor Yellow
    }
    
    exit 0
}

# 安裝模式
Write-Host ""
Write-Host "🔄 開始安裝漢化包..." -ForegroundColor Yellow

# 創建備份目錄
if (-not $NoBackup) {
    if (-not (Test-Path $BackupPath)) {
        New-Item -ItemType Directory -Path $BackupPath | Out-Null
        Write-Host "✅ 備份目錄已創建：$BackupPath" -ForegroundColor Green
    }
    
    # 備份原文件
    Write-Host "   備份原始文件中..." -ForegroundColor Gray
    $filesToBackup = @(
        "VOCALOID6.exe",
        "VOCALOID6.dll",
        "resources.dll"
    )
    
    foreach ($file in $filesToBackup) {
        $source = Join-Path $VocaloidPath $file
        if (Test-Path $source) {
            $dest = Join-Path $BackupPath $file
            Copy-Item $source $dest -Force
            Write-Host "   ✅ 備份：$file" -ForegroundColor Gray
        }
    }
}

# 複製漢化文件
Write-Host ""
Write-Host "   複製漢化文件中..." -ForegroundColor Gray
$汉 files = @(
    "data\translations\zh-TW.json",
    "data\translations\zh-CN.json",
    "data\translations\ja-JP.json",
    "data\translations\en-US.json"
)

foreach ($file in $汉 files) {
    $source = Join-Path $ScriptDir $file
    if (Test-Path $source) {
        Write-Host "   ✅ 安裝：$file" -ForegroundColor Gray
    } else {
        Write-Host "   ⚠️ 跳過（文件不存在）: $file" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ✅ 安裝完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "📌 下一步：" -ForegroundColor Cyan
Write-Host "   1. 啟動 VOCALOID6 Editor" -ForegroundColor White
Write-Host "   2. 進入 設置 → 語言 → 選擇 繁體中文" -ForegroundColor White
Write-Host "   3. 重啟 VOCALOID6 即可生效" -ForegroundColor White
Write-Host ""
Write-Host "🔧 卸載命令：" -ForegroundColor Cyan
Write-Host "   .\install.ps1 -Uninstall" -ForegroundColor White
Write-Host ""
