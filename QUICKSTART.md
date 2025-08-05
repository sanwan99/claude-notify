# ⚡ Claude Notify 快速使用指南

本指南帮助你在 **3 分钟内** 完成 Claude Notify 的安装和配置，让 Claude 自动通知你任务完成状态。

## 🎯 一句话说明

Claude Notify 让 Claude 在完成任务时通过 Windows 通知提醒你，不用再盯着屏幕等待了！

## 📋 前置要求

- ✅ Windows 10/11 + WSL
- ✅ Claude Code CLI 已安装
- ✅ 基本的命令行使用经验

## 🚀 四步完成安装

### 第 1 步：克隆并安装

```bash
# 克隆项目
git clone https://github.com/sanwan99/claude-notify.git
cd claude-notify

# 运行安装脚本
./install.sh
```

安装脚本会自动：
- 安装 BurntToast PowerShell 模块
- 设置脚本执行权限
- 测试通知功能

### 第 2 步：获取项目路径

```bash
# 在 claude-notify 目录中
pwd
```

记住输出的路径，例如：`/home/username/claude-notify`

### 第 3 步：配置 Claude 权限

在你的 **Claude 工作项目**（不是 claude-notify）根目录：

```bash
# 创建配置目录
mkdir -p .claude

# 创建配置文件
cat > .claude/settings.local.json << 'EOF'
{
  "permissions": {
    "allow": [
      "Bash(/home/username/claude-notify/interactive-notify.sh:*)",
      "Bash(/home/username/claude-notify/claude-notify.sh:*)",
      "Bash(/home/username/claude-notify/claude-shortcuts.sh:*)"
    ]
  },
  "additionalDirectories": [
    "/home/username/claude-notify"
  ]
}
EOF
```

⚠️ **重要**：将 `/home/username/claude-notify` 替换为第 2 步获取的实际路径！

## ✅ 验证安装

让 Claude 执行以下命令测试：

```bash
/path/to/claude-notify/claude-notify.sh success "安装成功" "Claude Notify 已准备就绪！"
```

如果看到 Windows 通知弹出，说明配置成功！

## 🤖 第 4 步：让 Claude 自动通知（重要！）

配置权限后，还需要告诉 Claude **什么时候**发送通知。推荐使用 CLAUDE.md：

```bash
# 在你的项目根目录
cp /path/to/claude-notify/CLAUDE.md.template ./CLAUDE.md

# 编辑 CLAUDE.md，修改通知脚本路径
nano CLAUDE.md
```

或者简单地在对话开始时告诉 Claude：

```
"从现在开始，完成任务后请用 /path/to/claude-notify/claude-notify.sh 通知我"
```

这样 Claude 就会在任务完成时自动发送通知了！

## 🎨 常用通知命令

### Claude 自动通知
```bash
# 任务成功
./claude-notify.sh success "数据分析完成" "处理了 10000 条记录"

# 任务失败
./claude-notify.sh error "构建失败" "发现 3 个错误"

# 需要确认
./claude-notify.sh warning "需要确认" "即将删除测试数据"
```

### 使用快捷函数
```bash
# 先加载函数
source /path/to/claude-notify/claude-shortcuts.sh

# 然后使用
claude_success "部署完成" "应用已上线"
claude_error "测试失败" "5 个测试用例未通过"
```

## 💡 最佳实践

1. **长时间任务**：让 Claude 在开始时发送"开始处理"通知，完成时发送"处理完成"通知
2. **错误处理**：出错时使用 `error` 类型，配合告警音效
3. **重要操作**：使用 `warning` 类型提醒需要确认的操作

## ❓ 遇到问题？

- **通知没弹出**：检查 Windows 通知设置
- **权限错误**：确认配置文件路径正确
- **BurntToast 错误**：重新运行 `install.sh`

更多帮助请查看：
- 📖 [完整文档](README.md)
- 🤖 [Claude 集成指南](CLAUDE-INTEGRATION.md)
- 💬 [GitHub Issues](https://github.com/sanwan99/claude-notify/issues)

---

**现在开始享受更高效的 Claude 使用体验吧！** 🎉