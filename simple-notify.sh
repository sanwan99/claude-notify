#!/bin/bash

# 简单的Windows通知脚本 - 降级版本
# 当BurntToast不可用时的备选方案

# 默认参数
TITLE="${1:-Claude Code}"
MESSAGE="${2:-任务完成！}"
TYPE="${3:-info}"

echo "📢 发送简单通知..."
echo "   标题: $TITLE"
echo "   消息: $MESSAGE"
echo "   类型: $TYPE"

# 根据类型选择不同的图标和声音
case $TYPE in
    "success")
        ICON="Information"
        SOUND="SystemHand"
        ;;
    "warning")
        ICON="Warning"
        SOUND="SystemExclamation"
        ;;
    "error")
        ICON="Error"
        SOUND="SystemHand"
        ;;
    *)
        ICON="Information"
        SOUND="SystemAsterisk"
        ;;
esac

# 使用PowerShell显示消息框
powershell.exe -Command "
    Add-Type -AssemblyName System.Windows.Forms;
    Add-Type -AssemblyName System.Media;
    [System.Media.SystemSounds]::$SOUND.Play();
    [System.Windows.Forms.MessageBox]::Show('$MESSAGE', '$TITLE', 'OK', '$ICON')
"

echo "✅ 通知已发送"