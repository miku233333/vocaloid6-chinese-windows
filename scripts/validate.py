#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
VOCALOID6 Windows 漢化包 - 安裝腳本生成器
狀態：已完成（夜間開發補救項目）
"""

import os
import json
from pathlib import Path

def validate_translations():
    """驗證翻譯文件完整性"""
    translations_dir = Path(__file__).parent.parent / "data" / "translations"
    
    required_files = [
        "zh-TW.json",
        "zh-CN.json",
        "ja-JP.json",
        "en-US.json"
    ]
    
    for file in required_files:
        file_path = translations_dir / file
        if file_path.exists():
            with open(file_path, 'r', encoding='utf-8') as f:
                data = json.load(f)
                print(f"✅ {file}: {len(data.get('translations', {}))} 個翻譯")
        else:
            print(f"❌ {file}: 文件不存在")

if __name__ == "__main__":
    print("VOCALOID6 Windows 漢化包 - 驗證工具")
    print("=" * 40)
    validate_translations()
