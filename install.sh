#!/bin/bash

# Claude Notify 一键安装脚本
# 让 Claude 完成任务时通知你！

echo "🚀 开始安装 Claude Notify..."
echo ""

# 获取当前脚本所在目录的绝对路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 1. 检查是否在 WSL 环境
if ! grep -qi microsoft /proc/version; then
    echo "❌ 错误：此脚本需要在 WSL 环境中运行"
    echo "   请在 Windows 10/11 的 WSL 中运行此脚本"
    exit 1
fi

echo "✅ 检测到 WSL 环境"

# 2. 安装 BurntToast PowerShell 模块
echo ""
echo "📦 正在安装 BurntToast 模块..."
echo "   需要 Windows 管理员权限，请在弹出的 PowerShell 窗口中确认"

# 检查 BurntToast 是否已安装
if powershell.exe -Command "Get-Module -ListAvailable -Name BurntToast" 2>/dev/null | grep -q "BurntToast"; then
    echo "✅ BurntToast 模块已安装"
else
    # 尝试安装 BurntToast
    powershell.exe -File "$SCRIPT_DIR/install-burnttoast.ps1"
    
    # 再次检查是否安装成功
    if powershell.exe -Command "Get-Module -ListAvailable -Name BurntToast" 2>/dev/null | grep -q "BurntToast"; then
        echo "✅ BurntToast 模块安装成功"
    else
        echo "⚠️  警告：BurntToast 模块可能未正确安装"
        echo "   通知功能将使用降级方案（消息框）"
    fi
fi

# 3. 设置脚本执行权限
echo ""
echo "🔧 设置脚本执行权限..."
chmod +x "$SCRIPT_DIR"/*.sh
echo "✅ 执行权限设置完成"

# 4. 测试通知功能
echo ""
echo "🧪 测试通知功能..."
"$SCRIPT_DIR/interactive-notify.sh" -t "Claude Notify" -m "安装成功！🎉" -T success

# 5. 显示 Claude 配置说明
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✅ Claude Notify 安装完成！"
echo ""
echo "📝 下一步：配置 Claude Code 权限"
echo ""
echo "在你的 Claude 项目根目录创建 .claude/settings.local.json 文件："
echo ""
echo "mkdir -p .claude"
echo "cat > .claude/settings.local.json << 'EOF'"
echo "{"
echo "  \"permissions\": {"
echo "    \"allow\": ["
echo "      \"Bash($SCRIPT_DIR/interactive-notify.sh:*)\","
echo "      \"Bash($SCRIPT_DIR/claude-notify.sh:*)\","
echo "      \"Bash($SCRIPT_DIR/claude-shortcuts.sh:*)\""
echo "    ]"
echo "  },"
echo "  \"additionalDirectories\": ["
echo "    \"$SCRIPT_DIR\""
echo "  ]"
echo "}"
echo "EOF"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "💡 提示：复制上面的配置，替换为你的实际路径即可！"
echo ""
echo "🎯 完成后，Claude 就能在任务完成时自动通知你了！"
echo ""
echo "📚 查看更多使用方法："
echo "   - 快速测试: ./simple-test.bat"
echo "   - 完整文档: cat README.md"
echo "   - Claude 集成: cat CLAUDE-INTEGRATION.md"
echo ""