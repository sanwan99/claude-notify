#!/bin/bash

# Claude任务暂停等待确认通知脚本
# 当Claude需要用户确认时发送提醒通知

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
NOTIFY_SCRIPT="$SCRIPT_DIR/interactive-notify.sh"

# 默认参数
PAUSE_REASON="${1:-等待用户确认}"
CUSTOM_MESSAGE="${2:-Claude任务已暂停，需要您的确认}"
URGENCY="${3:-normal}"

echo "⏸️ 发送Claude暂停等待通知..."
echo "   原因: $PAUSE_REASON"
echo "   消息: $CUSTOM_MESSAGE"

# 根据紧急程度设置不同样式
case "$URGENCY" in
    "urgent"|"high")
        TYPE="warning"
        SOUND="Alarm2"
        DURATION="Long"
        TITLE="🚨 Claude紧急等待"
        ICON="$SCRIPT_DIR/icons/warning.png"
        ;;
    "important"|"medium")
        TYPE="warning" 
        SOUND="Reminder"
        DURATION="Long"
        TITLE="⚠️ Claude重要确认"
        ICON="$SCRIPT_DIR/icons/warning.png"
        ;;
    *)
        TYPE="info"
        SOUND="SMS"
        DURATION="Short"
        TITLE="⏸️ Claude等待确认"
        ICON="$SCRIPT_DIR/icons/chabao.jpg"
        ;;
esac

# 发送通知
"$NOTIFY_SCRIPT" -t "$TITLE" -m "$CUSTOM_MESSAGE" -i "$ICON" -s "$SOUND" -T "$TYPE" -d "$DURATION" \
    -b1 "立即查看" -a1 "check-claude" -b2 "稍后处理" -a2 "remind-later"

echo "✅ 暂停等待通知已发送"

# 如果是紧急情况，发送茶宝特别提醒
if [[ "$URGENCY" == "urgent" ]]; then
    sleep 2
    "$SCRIPT_DIR/chabao-notify.sh" "茶宝紧急提醒" "Claude有紧急任务等待处理" "warning" "Alarm"
fi