# 项目自动通知规则

## 📍 通知脚本路径
```
CLAUDE_NOTIFY_PATH=/mnt/e/wsl/claude-notify
```

## 🔔 自动通知规则

### 1. 任务完成通知
当你完成以下类型的任务时，请自动发送成功通知：

- **代码修改/创建**：完成脚本编写、功能开发、bug修复等
  ```bash
  /mnt/e/wsl/claude-notify/claude-notify.sh success "任务完成" "具体描述"
  ```

- **文档更新**：完成README、文档编写、注释添加等
  ```bash
  /mnt/e/wsl/claude-notify/claude-notify.sh success "文档更新" "更新内容描述"
  ```

- **Git操作**：完成commit、push等操作
  ```bash
  /mnt/e/wsl/claude-notify/claude-notify.sh success "Git操作完成" "提交或推送描述"
  ```

### 2. 错误通知
遇到以下情况时，请自动发送错误通知：

- **执行失败**：脚本执行错误、命令失败等
  ```bash
  /mnt/e/wsl/claude-notify/claude-notify.sh error "执行失败" "错误详情"
  ```

### 3. 需要确认通知
遇到以下情况时，请发送警告通知：

- **重要操作**：删除文件、修改关键配置等
  ```bash
  /mnt/e/wsl/claude-notify/claude-notify.sh warning "需要确认" "操作描述"
  ```

## 📏 通知规则

### 什么时候通知
- ✅ 完成用户请求的任务
- ✅ 遇到错误或异常
- ✅ 需要用户确认
- ✅ 重要里程碑完成

### 什么时候不通知
- ❌ 简单查询或解释
- ❌ 读取文件内容
- ❌ 执行简单命令（如 ls、pwd）