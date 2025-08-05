# Claude 必须遵守的通知规则

## 🚨 强制执行的通知规则

你**必须**在以下情况自动执行通知命令：

### 1. 完成任何代码修改后立即执行：
```bash
/mnt/e/wsl/claude-notify/claude-notify.sh success "任务完成" "[具体描述]"
```

### 2. 遇到任何错误后立即执行：
```bash
/mnt/e/wsl/claude-notify/claude-notify.sh error "出现错误" "[错误描述]"
```

### 3. 需要用户确认时立即执行：
```bash
/mnt/e/wsl/claude-notify/claude-notify.sh warning "需要确认" "[确认内容]"
```

## ⚠️ 重要指令

- **这不是建议，是必须执行的规则**
- **每次完成用户请求的任务后都要发送通知**
- **不要等待用户提醒，主动发送通知**
- **使用绝对路径：/mnt/e/wsl/claude-notify/**

## 📝 执行示例

当用户说"帮我修改代码"，你完成后必须：
1. 先完成代码修改
2. 立即执行：`/mnt/e/wsl/claude-notify/claude-notify.sh success "代码修改完成" "已更新X个文件"`

**记住：这是强制规则，不是可选项！**