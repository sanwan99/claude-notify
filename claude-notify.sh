#!/bin/bash

# Claude Code 任务完成自动通知脚本
# 用于在Claude完成任务后自动发送Windows Toast通知

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
NOTIFY_SCRIPT="$SCRIPT_DIR/interactive-notify.sh"

# 默认参数
TASK_TYPE="${1:-general}"
TASK_TITLE="${2:-Claude任务完成}"
TASK_MESSAGE="${3:-任务已成功完成}"
CUSTOM_ICON="${4:-}"
CUSTOM_SOUND="${5:-}"

# 根据任务类型设置不同的通知样式
case "$TASK_TYPE" in
    "success"|"completed")
        ICON="icons/success.png"
        SOUND="Default"
        TYPE="success"
        MESSAGE="✅ $TASK_MESSAGE"
        ;;
    "error"|"failed")
        ICON="icons/error.png"
        SOUND="Alarm2"
        TYPE="error"
        MESSAGE="❌ $TASK_MESSAGE"
        ;;
    "warning"|"attention")
        ICON="icons/warning.png"
        SOUND="Reminder"
        TYPE="warning"
        MESSAGE="⚠️ $TASK_MESSAGE"
        ;;
    "build"|"compile")
        ICON="icons/success.png"
        SOUND="Default"
        TYPE="success"
        MESSAGE="🔨 $TASK_MESSAGE"
        ;;
    "test"|"testing")
        ICON="icons/info.png"
        SOUND="SMS"
        TYPE="info"
        MESSAGE="🧪 $TASK_MESSAGE"
        ;;
    "deploy"|"deployment")
        ICON="icons/success.png"
        SOUND="Mail"
        TYPE="success"
        MESSAGE="🚀 $TASK_MESSAGE"
        ;;
    *)
        ICON="icons/info.png"
        SOUND="SMS"
        TYPE="info"
        MESSAGE="📋 $TASK_MESSAGE"
        ;;
esac

# 如果提供了自定义图标和音效，则使用自定义设置
if [[ -n "$CUSTOM_ICON" ]]; then
    ICON="$CUSTOM_ICON"
fi

if [[ -n "$CUSTOM_SOUND" ]]; then
    SOUND="$CUSTOM_SOUND"
fi

# 发送通知
echo "🔔 发送Claude任务完成通知..."
echo "   任务类型: $TASK_TYPE"
echo "   标题: $TASK_TITLE"
echo "   消息: $MESSAGE"

# 处理自定义图标（可能是Windows路径）
if [[ -n "$CUSTOM_ICON" ]]; then
    ICON="$CUSTOM_ICON"
fi

"$NOTIFY_SCRIPT" -t "$TASK_TITLE" -m "$MESSAGE" -i "$ICON" -s "$SOUND" -T "$TYPE" \
    -b1 "查看详情" -a1 "view-details" -b2 "继续工作" -a2 "continue-work"

echo "✅ 通知已发送"