#!/bin/bash

# 高级可交互Windows通知脚本
# 支持BurntToast的所有功能

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
TOAST_SCRIPT=$(wslpath -w "$SCRIPT_DIR/toast-notify.ps1")

# 默认参数
TITLE="Claude Code"
MESSAGE="任务完成！"
TYPE="info"
BUTTON1_TEXT=""
BUTTON1_ACTION=""
BUTTON2_TEXT=""
BUTTON2_ACTION=""
DURATION="Short"
ICON=""
CUSTOM_SOUND=""

# 帮助信息
show_help() {
    cat << EOF
🚀 Claude Code 高级可交互通知系统

用法: $0 [选项]

基本选项:
  -t, --title TEXT        通知标题 (默认: "Claude Code")
  -m, --message TEXT      通知消息 (默认: "任务完成！")
  -T, --type TYPE         通知类型: info|success|warning|error (默认: info)
  -d, --duration TIME     显示时长: Short|Long (默认: Short)

自定义选项:
  -i, --icon PATH         自定义图标路径 (PNG/JPG格式)
  -s, --sound NAME        自定义音效 (Default|SMS|Mail|Reminder|Alarm等)

交互选项:
  -b1, --button1 TEXT     第一个按钮文本
  -a1, --action1 ACTION   第一个按钮动作
  -b2, --button2 TEXT     第二个按钮文本  
  -a2, --action2 ACTION   第二个按钮动作

示例:
  # 基本通知
  $0 -t "数据分析" -m "客户报表已生成"
  
  # 成功通知
  $0 -t "构建完成" -m "Maven编译成功" -T success
  
  # 自定义图标通知
  $0 -t "部署完成" -m "应用已发布" -i /path/to/deploy.png
  
  # 自定义音效通知  
  $0 -t "紧急告警" -m "服务器异常" -s Alarm2
  
  # 组合自定义
  $0 -t "特殊事件" -m "重要提醒" -i custom.png -s Mail
  
  # 带按钮的交互通知
  $0 -t "报告生成" -m "点击查看详情" \\
     -b1 "查看报告" -a1 "open-report" \\
     -b2 "发送邮件" -a2 "send-email"
  
  # 错误通知
  $0 -t "构建失败" -m "发现3个编译错误" -T error -d Long

通知类型说明:
  info     - 蓝色图标，默认SMS提示音
  success  - 绿色图标，Default提示音  
  warning  - 黄色图标，Reminder提示音
  error    - 红色图标，Alarm提示音

音效选项说明:
  单次播放: Default, SMS, Mail, Reminder, IM
  循环告警: Alarm, Alarm2-Alarm10, Call, Call2-Call10
  
图标格式支持: PNG, JPG, ICO (建议64x64像素)
EOF
}

# 解析参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--title)
            TITLE="$2"
            shift 2
            ;;
        -m|--message)
            MESSAGE="$2"
            shift 2
            ;;
        -T|--type)
            TYPE="$2"
            shift 2
            ;;
        -d|--duration)
            DURATION="$2"
            shift 2
            ;;
        -i|--icon)
            ICON="$2"
            shift 2
            ;;
        -s|--sound)
            CUSTOM_SOUND="$2"
            shift 2
            ;;
        -b1|--button1)
            BUTTON1_TEXT="$2"
            shift 2
            ;;
        -a1|--action1)
            BUTTON1_ACTION="$2"
            shift 2
            ;;
        -b2|--button2)
            BUTTON2_TEXT="$2"
            shift 2
            ;;
        -a2|--action2)
            BUTTON2_ACTION="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            # 位置参数支持
            if [[ -z "$TITLE" || "$TITLE" == "Claude Code" ]]; then
                TITLE="$1"
            elif [[ -z "$MESSAGE" || "$MESSAGE" == "任务完成！" ]]; then
                MESSAGE="$1"
            fi
            shift
            ;;
    esac
done

# 发送通知的函数
send_notification() {
    echo "🚀 发送高级通知..."
    echo "   标题: $TITLE"
    echo "   消息: $MESSAGE"
    echo "   类型: $TYPE"
    
    # 构建PowerShell命令
    local ps_command="powershell.exe -ExecutionPolicy Bypass -File \"$TOAST_SCRIPT\""
    ps_command="$ps_command -Title \"$TITLE\" -Message \"$MESSAGE\" -Type \"$TYPE\" -Duration \"$DURATION\""
    
    # 处理图标路径转换
    if [[ -n "$ICON" ]]; then
        # 检查路径类型
        if [[ "$ICON" =~ ^[A-Za-z]:\\ ]]; then
            # 已经是Windows路径格式，直接使用
            local win_icon_path="$ICON"
        elif [[ "$ICON" != /* ]]; then
            # 相对路径，基于脚本目录转换
            ICON="$SCRIPT_DIR/$ICON"
            local win_icon_path=$(wslpath -w "$ICON")
        else
            # Linux绝对路径，转换为Windows路径
            local win_icon_path=$(wslpath -w "$ICON")
        fi
        
        ps_command="$ps_command -Icon \"$win_icon_path\""
        echo "   图标: $win_icon_path"
    fi
    
    # 添加自定义音效
    if [[ -n "$CUSTOM_SOUND" ]]; then
        ps_command="$ps_command -CustomSound \"$CUSTOM_SOUND\""
        echo "   音效: $CUSTOM_SOUND"
    fi
    
    if [[ -n "$BUTTON1_TEXT" ]]; then
        ps_command="$ps_command -Button1Text \"$BUTTON1_TEXT\""
        if [[ -n "$BUTTON1_ACTION" ]]; then
            ps_command="$ps_command -Button1Action \"$BUTTON1_ACTION\""
        fi
        echo "   按钮1: $BUTTON1_TEXT"
    fi
    
    if [[ -n "$BUTTON2_TEXT" ]]; then
        ps_command="$ps_command -Button2Text \"$BUTTON2_TEXT\""
        if [[ -n "$BUTTON2_ACTION" ]]; then
            ps_command="$ps_command -Button2Action \"$BUTTON2_ACTION\""
        fi
        echo "   按钮2: $BUTTON2_TEXT"
    fi
    
    # 执行PowerShell命令
    eval $ps_command
}

# 预设的快捷通知函数
notify_success() {
    TYPE="success"
    send_notification
}

notify_warning() {
    TYPE="warning"
    send_notification
}

notify_error() {
    TYPE="error"
    DURATION="Long"
    send_notification
}

notify_info() {
    TYPE="info"
    send_notification
}

# 检查是否通过函数名调用
case "$(basename "$0")" in
    *success*)
        notify_success
        ;;
    *warning*)
        notify_warning
        ;;
    *error*)
        notify_error
        ;;
    *)
        send_notification
        ;;
esac