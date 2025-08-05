#!/bin/bash

# 茶宝专用通知脚本
# 使用您的自定义茶宝图标发送通知

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
NOTIFY_SCRIPT="$SCRIPT_DIR/interactive-notify.sh"
CHABAO_ICON="$SCRIPT_DIR/icons/chabao.jpg"

# 默认参数
TITLE="${1:-茶宝提醒}"
MESSAGE="${2:-该休息喝茶了}"
TYPE="${3:-info}"
SOUND="${4:-Default}"

# 茶宝通知函数
send_chabao_notification() {
    local title="${1:-$TITLE}"
    local message="${2:-$MESSAGE}"
    local type="${3:-$TYPE}"
    local sound="${4:-$SOUND}"
    
    echo "🍵 发送茶宝专属通知..."
    echo "   标题: $title"
    echo "   消息: $message"
    echo "   类型: $type"
    
    "$NOTIFY_SCRIPT" -t "$title" -m "$message" -i "$CHABAO_ICON" -s "$sound" -T "$type" \
        -b1 "喝茶时间" -a1 "tea-time" -b2 "继续工作" -a2 "continue-work"
    
    echo "✅ 茶宝通知已发送"
}

# 预设的茶宝通知类型
case "$1" in
    "work-break")
        send_chabao_notification "茶宝提醒" "工作一小时了，该休息喝茶了" "warning" "Reminder"
        ;;
    "task-done")
        send_chabao_notification "茶宝庆祝" "任务完成，来杯茶庆祝一下" "success" "Default"
        ;;
    "tea-time")
        send_chabao_notification "茶宝邀请" "下午茶时间到了" "info" "Mail"
        ;;
    "good-job")
        send_chabao_notification "茶宝点赞" "干得漂亮！奖励自己一杯好茶" "success" "Default"
        ;;
    "help"|"-h"|"--help")
        echo "🍵 茶宝专用通知系统"
        echo ""
        echo "用法:"
        echo "  $0 [标题] [消息] [类型] [音效]"
        echo ""
        echo "预设通知:"
        echo "  $0 work-break  - 工作休息提醒"
        echo "  $0 task-done   - 任务完成庆祝"
        echo "  $0 tea-time    - 下午茶时间"  
        echo "  $0 good-job    - 表扬奖励"
        echo ""
        echo "示例:"
        echo "  $0 '茶宝问候' '今天过得怎么样' 'info' 'SMS'"
        ;;
    *)
        # 直接调用通知
        send_chabao_notification "$@"
        ;;
esac