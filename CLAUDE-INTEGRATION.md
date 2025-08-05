# 🤖 Claude Code 自动通知集成

## 🎯 功能说明

现在Claude在完成任务后可以自动发送Windows Toast通知提醒您！

## 🚀 使用方法

### 方法1：直接调用（推荐）
在任何Claude任务完成后，Claude可以直接调用：

```bash
# 成功通知
./claude-notify.sh success "任务标题" "任务描述"

# 错误通知  
./claude-notify.sh error "构建失败" "发现编译错误"

# 构建通知
./claude-notify.sh build "Maven构建" "项目编译完成"
```

### 方法2：快捷函数（高级）
Claude可以先载入函数，然后使用简化调用：

```bash
# 载入快捷函数
source ./claude-shortcuts.sh

# 使用快捷函数
claude_success "数据分析完成" "客户报表已生成"
claude_build "前端构建" "React应用编译成功"  
claude_deploy "部署完成" "应用已上线"
```

## 📋 支持的通知类型

| 类型 | 说明 | 图标 | 音效 |
|------|------|------|------|
| `success` | 任务成功 | 绿色对勾 | Default |
| `error` | 任务失败 | 红色X | Alarm2 |
| `warning` | 警告提醒 | 黄色三角 | Reminder |
| `build` | 构建完成 | 绿色对勾 | Default |
| `test` | 测试完成 | 蓝色i | SMS |
| `deploy` | 部署完成 | 绿色对勾 | Mail |
| `general` | 通用通知 | 蓝色i | SMS |

## ⏸️ 暂停等待通知

当Claude需要用户确认时，可以发送暂停等待通知：

```bash
# 直接调用暂停通知
./claude-pause-notify.sh "等待确认" "需要您的确认" "important"

# 使用快捷函数（推荐）
source ./claude-shortcuts.sh
claude_confirm "数据库操作" "即将删除测试数据，请确认"
claude_urgent "生产环境操作" "检测到生产环境操作，需要确认" 
claude_pause "等待输入" "需要您提供参数" "normal"
```

### 暂停通知优先级

| 优先级 | 图标 | 音效 | 持续时间 | 使用场景 |
|--------|------|------|----------|----------|
| `normal` | 茶宝 | SMS | 短 | 一般确认 |
| `important` | 警告⚠️ | Reminder | 长 | 重要操作确认 |
| `urgent` | 紧急🚨 | Alarm2 | 长 | 安全敏感操作 + 茶宝双重提醒 |

## 🎨 自定义通知

```bash
# 完全自定义
./claude-notify.sh "custom" "自定义标题" "自定义消息" "icons/warning.png" "Alarm3"

# 使用快捷函数自定义
claude_notify "warning" "注意事项" "系统需要重启" "icons/warning.png" "Reminder"
```

## 📝 建议的使用场景

**代码任务**：
- 编译完成 → `claude_build`
- 测试通过 → `claude_test` 
- 部署成功 → `claude_deploy`

**分析任务**：
- 数据分析完成 → `claude_success`
- 报告生成完成 → `claude_success`
- 错误修复完成 → `claude_success`

**出现问题**：
- 编译失败 → `claude_error`
- 测试失败 → `claude_error`
- 需要人工介入 → `claude_error`

**用户交互**：
- 需要确认 → `claude_confirm`
- 紧急确认 → `claude_urgent`
- 等待输入 → `claude_pause`

## 🍵 个性化通知

系统支持茶宝等个性化通知：

```bash
# 茶宝专属通知
./chabao-notify.sh "茶宝提醒" "该休息了"

# 预设茶宝通知
./chabao-notify.sh work-break   # 工作休息
./chabao-notify.sh task-done    # 任务完成
./chabao-notify.sh tea-time     # 下午茶时间
./chabao-notify.sh good-job     # 表扬奖励
```

## 🔧 集成状态

✅ 权限已配置：Claude可以调用所有通知脚本
✅ 脚本已就绪：所有通知功能正常工作
✅ 测试通过：通知系统运行正常

现在Claude会在适当的时候自动提醒您任务完成状态！