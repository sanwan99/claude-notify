#!/bin/bash

# Claude Code 通知快捷函数
# 在Claude任务中可以直接调用这些函数

NOTIFY_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# 任务成功完成通知
claude_success() {
    local title="${1:-Claude任务完成}"
    local message="${2:-任务已成功完成}"
    "$NOTIFY_DIR/claude-notify.sh" "success" "$title" "$message"
}

# 任务失败通知
claude_error() {
    local title="${1:-Claude任务失败}"
    local message="${2:-任务执行过程中出现错误}"
    "$NOTIFY_DIR/claude-notify.sh" "error" "$title" "$message"
}

# 构建完成通知
claude_build() {
    local title="${1:-构建完成}"
    local message="${2:-项目构建已完成}"
    "$NOTIFY_DIR/claude-notify.sh" "build" "$title" "$message"
}

# 测试完成通知
claude_test() {
    local title="${1:-测试完成}"
    local message="${2:-所有测试已执行完毕}"
    "$NOTIFY_DIR/claude-notify.sh" "test" "$title" "$message"
}

# 部署完成通知
claude_deploy() {
    local title="${1:-部署完成}"
    local message="${2:-应用已成功部署}"
    "$NOTIFY_DIR/claude-notify.sh" "deploy" "$title" "$message"
}

# 暂停等待用户确认通知
claude_pause() {
    local reason="${1:-等待用户确认}"
    local message="${2:-Claude任务已暂停，需要您的确认}"
    local urgency="${3:-normal}"
    "$NOTIFY_DIR/claude-pause-notify.sh" "$reason" "$message" "$urgency"
}

# 重要确认通知（中等优先级）
claude_confirm() {
    local title="${1:-需要确认}"
    local message="${2:-Claude需要您的确认才能继续}"
    "$NOTIFY_DIR/claude-pause-notify.sh" "$title" "$message" "important"
}

# 紧急等待通知（高优先级）
claude_urgent() {
    local title="${1:-紧急确认}"
    local message="${2:-检测到重要情况，需要您的紧急确认}"
    "$NOTIFY_DIR/claude-pause-notify.sh" "$title" "$message" "urgent"
}

# 自定义通知
claude_notify() {
    local type="${1:-general}"
    local title="${2:-Claude通知}"
    local message="${3:-有新的消息}"
    local icon="${4:-}"
    local sound="${5:-}"
    "$NOTIFY_DIR/claude-notify.sh" "$type" "$title" "$message" "$icon" "$sound"
}

# 如果脚本被直接执行，显示帮助信息
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "🚀 Claude Code 通知快捷函数"
    echo ""
    echo "可用函数："
    echo "  claude_success [title] [message]  - 成功通知"
    echo "  claude_error [title] [message]    - 错误通知"
    echo "  claude_build [title] [message]    - 构建通知"
    echo "  claude_test [title] [message]     - 测试通知"
    echo "  claude_deploy [title] [message]   - 部署通知"
    echo "  claude_pause [reason] [message] [urgency] - 暂停等待通知"
    echo "  claude_confirm [title] [message]  - 重要确认通知"
    echo "  claude_urgent [title] [message]   - 紧急等待通知"
    echo "  claude_notify type title message [icon] [sound] - 自定义通知"
    echo ""
    echo "使用方法："
    echo "  source $0  # 载入函数"
    echo "  claude_success \"任务完成\" \"数据处理成功\""
    echo ""
    echo "示例："
    claude_success "演示通知" "这是一个成功通知的演示"
fi