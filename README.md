# 🔔 Claude Notify - 让 Claude 完成任务时通知你

**再也不用盯着屏幕等 Claude 跑完任务了！**

当 Claude 在处理耗时任务时，你可以去泡咖啡、处理邮件或专注其他工作。任务完成时，Windows 会弹出通知提醒你回来查看结果。

![Claude Notify Demo](https://github.com/sanwan99/claude-notify/assets/demo.gif)

## 🤔 为什么需要这个？

你是否遇到过这些情况：
- 📊 让 Claude 分析大量数据，然后等了半天...
- 🔨 让 Claude 重构整个项目，不知道什么时候能完成...
- 🧪 让 Claude 跑测试，切换到其他窗口就忘记了...
- ⚠️ Claude 需要你确认某个操作，但你没注意到...

**Claude Notify** 解决了这些痛点：
- ✅ 任务完成时自动弹出 Windows 通知
- ❌ 任务失败时立即告警提醒
- 🔔 需要确认时发送醒目通知
- 🎨 不同类型任务使用不同图标和音效

## 🚀 快速开始（4步完成）

### 1️⃣ 克隆项目
```bash
git clone https://github.com/sanwan99/claude-notify.git
cd claude-notify
```

### 2️⃣ 运行安装脚本
```bash
./install.sh
```

### 3️⃣ 配置 Claude 权限
在你的 Claude 项目根目录创建 `.claude/settings.local.json`：

```json
{
  "permissions": {
    "allow": [
      "Bash(/path/to/claude-notify/interactive-notify.sh:*)",
      "Bash(/path/to/claude-notify/claude-notify.sh:*)",
      "Bash(/path/to/claude-notify/claude-shortcuts.sh:*)"
    ]
  },
  "additionalDirectories": [
    "/path/to/claude-notify"
  ]
}
```

**注意**：将 `/path/to/claude-notify` 替换为你实际的项目路径！

### 4️⃣ 设置自动通知规则（别忘了这步！）
在你的项目根目录创建或编辑 `CLAUDE.md` 文件，在**最前面**添加通知规则：

```bash
# 如果是新项目，复制模板
cp /path/to/claude-notify/CLAUDE.md.example ./CLAUDE.md

# 编辑文件，确保通知规则在最前面
nano CLAUDE.md
```

⚠️ **重要**：通知规则必须放在 CLAUDE.md 的**最顶部**！

🎉 **完成！** 现在 Claude 会在任务完成时自动通知你了！

## 🤖 如何让 Claude 自动通知（重要！）

⚠️ **很多用户忽略了这一步！** 配置权限后，Claude 有了调用通知脚本的**能力**，但还需要告诉它**什么时候**调用。

### 方法 1：创建 CLAUDE.md（强烈推荐）
**这是最关键的一步！** 在你的项目根目录创建 `CLAUDE.md` 文件，把以下内容放在文件**最前面**：

```markdown
## 通知脚本位置
NOTIFY_PATH=/mnt/e/wsl/claude-notify

## 自动通知规则

你必须在以下情况执行通知：

1. **完成任务后立即执行**：
   `$NOTIFY_PATH/claude-notify.sh success "任务完成" "描述"`

2. **遇到错误时立即执行**：
   `$NOTIFY_PATH/claude-notify.sh error "任务失败" "错误信息"`

3. **需要确认时立即执行**：
   `$NOTIFY_PATH/claude-notify.sh warning "需要确认" "确认内容"`

**重要：这是必须执行的规则，每次都要执行，不要等待提醒。**
```

⚠️ **关键提示**：
- 这段规则必须放在 CLAUDE.md 文件的**最前面**
- 修改 `NOTIFY_PATH` 为你的实际路径
- 如果已有 CLAUDE.md，把这段加在最顶部

📌 **提示**：也可以直接复制 `claude-notify/CLAUDE.md.example` 到你的项目根目录并修改路径。

### 方法 2：在对话开始时设定
在与 Claude 对话的开始，明确告诉它：

```
"从现在开始，每当你完成重要任务时，请使用 /home/username/claude-notify/claude-notify.sh 通知我。
- 任务成功用 success 类型
- 任务失败用 error 类型  
- 需要确认用 warning 类型"
```

### 方法 3：在具体任务中指定
针对特定任务要求通知：

```
"帮我分析这个 10GB 的日志文件，完成后用 claude-notify 通知我结果"
"重构这个项目，每完成一个模块就通知我进度"
```

### 🎯 最佳实践

1. **CLAUDE.md 是最推荐的方式**，因为：
   - 规则持久化，不用每次都说
   - 团队成员都能看到规则
   - Claude 会自动遵守项目规则

2. **通知时机建议**：
   - 耗时超过 30 秒的任务
   - 需要人工确认的操作
   - 任务失败或遇到错误
   - 重要里程碑完成

3. **避免过度通知**：
   - 简单查询不需要通知
   - 连续小任务可以合并通知
   - 设置合理的通知阈值

## 📖 Claude 权限配置详解

### 找到你的项目路径
```bash
# 在 claude-notify 目录中运行
pwd
# 输出类似：/home/username/claude-notify
```

### 创建配置文件
```bash
# 在你的 Claude 项目根目录
mkdir -p .claude
nano .claude/settings.local.json
```

### 配置示例
如果你的 claude-notify 在 `/home/john/tools/claude-notify`：

```json
{
  "permissions": {
    "allow": [
      "Bash(/home/john/tools/claude-notify/interactive-notify.sh:*)",
      "Bash(/home/john/tools/claude-notify/claude-notify.sh:*)",
      "Bash(/home/john/tools/claude-notify/claude-shortcuts.sh:*)"
    ]
  },
  "additionalDirectories": [
    "/home/john/tools/claude-notify"
  ]
}
```

### ❓ 常见问题

**Q: 为什么需要配置权限？**  
A: Claude Code 默认不能执行外部脚本，需要明确授权才能调用通知功能。

**Q: 配置文件放在哪里？**  
A: 放在你让 Claude 工作的项目根目录，不是 claude-notify 目录。

**Q: 如何验证配置成功？**  
A: 让 Claude 执行 `./claude-notify.sh success "测试" "配置成功"`，如果弹出通知说明配置正确。

## 🎯 使用示例

### Claude 自动通知场景

当 Claude 完成以下任务时会自动通知你：

```bash
# 数据分析完成
"Claude 正在分析 10GB 的日志文件..."
→ 通知："数据分析完成 - 发现 1,234 个异常记录"

# 代码重构完成  
"Claude 正在重构整个项目架构..."
→ 通知："重构完成 - 修改了 89 个文件"

# 测试执行完成
"Claude 正在运行完整的测试套件..."
→ 通知："测试完成 - 通过 456/460，4 个失败"

# 需要用户确认
"Claude 检测到将要删除生产数据..."
→ 通知："⚠️ 需要确认 - 即将执行危险操作"
```

### 手动调用示例

你也可以在脚本中手动调用：

```bash
# 基础通知
./claude-notify.sh success "部署完成" "应用已发布到生产环境"

# 错误通知
./claude-notify.sh error "构建失败" "发现 3 个编译错误"

# 使用快捷函数
source ./claude-shortcuts.sh
claude_success "任务完成" "所有数据已处理"
claude_error "操作失败" "数据库连接超时"
```

### 与 CI/CD 集成

```bash
# 在构建脚本中
npm run build
if [ $? -eq 0 ]; then
    ./claude-notify.sh success "构建成功" "前端资源已编译"
else
    ./claude-notify.sh error "构建失败" "请检查错误日志"
fi
```

## 🔧 工作原理

```
Claude 执行任务
      ↓
调用通知脚本
      ↓
WSL 路径转换为 Windows 路径
      ↓
PowerShell 调用 BurntToast
      ↓
Windows 10/11 弹出 Toast 通知
```

关键特性：
- 🔄 自动处理 WSL 和 Windows 路径转换
- 📦 基于 BurntToast PowerShell 模块
- 🛡️ 包含降级机制（BurntToast 不可用时使用消息框）
- 🎨 支持自定义图标、音效和交互按钮

## 📋 通知类型

| 类型 | 图标 | 音效 | 使用场景 |
|------|------|------|----------|
| `success` | ✅ 绿色 | Default | 任务成功完成 |
| `error` | ❌ 红色 | Alarm2 | 任务失败或错误 |
| `warning` | ⚠️ 黄色 | Reminder | 警告或需要注意 |
| `info` | ℹ️ 蓝色 | SMS | 一般信息提醒 |
| `build` | 🔨 绿色 | Default | 构建完成 |
| `deploy` | 🚀 绿色 | Mail | 部署完成 |

## 🎨 高级功能

### 自定义图标和音效
```bash
./interactive-notify.sh -t "自定义通知" -m "使用自定义图标" \
    -i /path/to/icon.png -s Mail
```

### 交互式按钮
```bash
./interactive-notify.sh -t "报告生成" -m "点击查看" \
    -b1 "打开报告" -a1 "open-report" \
    -b2 "发送邮件" -a2 "send-email"
```

### 长时间显示
```bash
./interactive-notify.sh -t "重要提醒" -m "需要立即处理" \
    -T error -d Long
```

## 📁 项目结构

```
claude-notify/
├── 📜 核心脚本
│   ├── interactive-notify.sh      # 主通知脚本
│   ├── claude-notify.sh          # Claude 集成脚本
│   ├── claude-shortcuts.sh       # 快捷函数库
│   ├── toast-notify.ps1          # PowerShell 实现
│   └── simple-notify.sh          # 降级方案（消息框）
├── 🔧 安装工具
│   ├── install.sh                # 一键安装脚本
│   └── install-burnttoast.ps1    # BurntToast 安装脚本
├── 🎨 资源文件
│   └── icons/                    # 预设图标（success/warning/error/info）
└── 📋 模板
    └── CLAUDE.md.example        # CLAUDE.md 示例模板
```

## 🤝 贡献

欢迎贡献代码和建议！

1. Fork 本项目
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的改动 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

### 贡献想法
- 🌐 支持更多通知平台（Discord、Slack 等）
- 🎨 更多预设图标和音效
- 🔧 GUI 配置工具
- 📱 移动端通知支持

## ❓ 常见问题

**Q: Claude 不自动发送通知怎么办？**  
A: 最常见的原因和解决方法：
1. **检查 CLAUDE.md 文件**：确保在项目根目录，且使用绝对路径
2. **规则要明确**：使用"你必须"而不是"请"，Claude 对指令式语言响应更好
3. **测试命令**：先让 Claude 手动执行一次通知命令，确认路径正确
4. **重新开始对话**：有时需要新对话才能加载 CLAUDE.md 规则

**Q: BurntToast 模块安装失败怎么办？**  
A: 以管理员权限运行 PowerShell，执行：
```powershell
Install-Module -Name BurntToast -Force
```

**Q: 通知没有弹出？**  
A: 检查 Windows 通知设置，确保允许 PowerShell 发送通知。

**Q: 中文显示乱码？**  
A: 这是 WSL 和 PowerShell 编码问题，不影响功能使用。

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

---

**如果这个项目对你有帮助，请给个 ⭐ Star！**

有问题或建议？[提交 Issue](https://github.com/sanwan99/claude-notify/issues) 或 [发起 Discussion](https://github.com/sanwan99/claude-notify/discussions)

Made with ❤️ for Claude users