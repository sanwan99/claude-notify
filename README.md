# 🚀 WSL Windows 交互式通知系统

基于 BurntToast 的高级 Windows Toast 通知系统，专为 WSL 环境设计，支持交互式按钮和多种通知类型。

## 🏗️ 快速开始

### 1. 克隆项目
```bash
git clone https://github.com/your-username/claude-notify.git
cd claude-notify
```

### 2. 安装配置
```bash
# 安装 BurntToast 模块（管理员权限运行）
powershell.exe -File install-burnttoast.ps1

# 设置执行权限
chmod +x *.sh

# 一键测试
./simple-test.bat  # Windows环境
# 或
./test-enhanced-notifications.sh  # WSL环境
```

### 3. Claude Code 集成配置
将项目路径中的 `<PROJECT_PATH>` 替换为你的实际项目路径，例如 `/home/user/claude-notify`。

## ✨ 功能特性

### 🎯 通知类型
- **info** - 蓝色图标，默认SMS提示音
- **success** - 绿色图标，默认提示音  
- **warning** - 黄色图标，提醒音效
- **error** - 红色图标，告警音效

### ⚡ 交互功能
- 支持最多2个自定义按钮
- 按钮可关联自定义动作标识
- 支持短时间/长时间显示模式
- 自动降级机制（BurntToast不可用时使用消息框）

### 🎨 自定义功能
- **自定义图标** - 支持PNG/JPG/ICO格式，自动路径转换
- **自定义音效** - 支持15+种内置音效，包括单次播放和循环告警
- **预设图标库** - 提供常用的success/warning/error/info图标
- **智能路径处理** - 自动转换WSL路径到Windows路径

### 🤖 Claude Code 集成
- **自动任务通知** - Claude完成任务后自动发送Windows通知
- **智能分类提醒** - 根据任务类型自动选择图标、音效和样式
- **暂停等待提醒** - Claude需要确认时及时通知用户
- **个性化通知** - 支持茶宝等个人定制图标
- **一键集成** - 预配置权限，Claude可直接调用通知功能
- **快捷函数** - 提供简化的调用接口

### 🔧 智能特性
- 跨平台兼容（WSL ↔ Windows）
- 参数验证和错误处理
- 详细的使用帮助文档
- 音效和图标自动匹配

## 📦 安装配置

### 1. 安装 BurntToast 模块

```powershell
# 以管理员权限运行 PowerShell
powershell.exe -File install-burnttoast.ps1
```

### 2. 设置执行权限

```bash
chmod +x *.sh
```

### 3. 测试安装

```bash
./test-notifications.sh
```

## 🚀 使用方法

### 基本用法

```bash
# 基本通知
./interactive-notify.sh -t "任务标题" -m "通知消息"

# 指定通知类型
./interactive-notify.sh -t "构建完成" -m "Maven编译成功" -T success
```

### 高级用法

```bash
# 自定义图标通知
./interactive-notify.sh -t "部署完成" -m "应用已发布" -i icons/success.png

# 自定义音效通知
./interactive-notify.sh -t "紧急告警" -m "服务器异常" -s Alarm2

# 组合自定义功能
./interactive-notify.sh -t "特殊事件" -m "重要提醒" -i custom.png -s Mail

# 带按钮的交互通知
./interactive-notify.sh -t "报告生成" -m "点击查看详情" -T success \\
    -b1 "查看报告" -a1 "open-report" \\
    -b2 "发送邮件" -a2 "send-email"

# 长时间显示的错误通知
./interactive-notify.sh -t "构建失败" -m "发现编译错误" -T error -d Long
```

### 参数说明

| 参数 | 长参数 | 说明 | 默认值 |
|------|--------|------|--------|
| `-t` | `--title` | 通知标题 | "Claude Code" |
| `-m` | `--message` | 通知消息 | "任务完成！" |
| `-T` | `--type` | 通知类型 | "info" |
| `-d` | `--duration` | 显示时长 | "Short" |
| `-i` | `--icon` | 自定义图标路径 | "" |
| `-s` | `--sound` | 自定义音效名称 | "" |
| `-b1` | `--button1` | 第一个按钮文本 | "" |
| `-a1` | `--action1` | 第一个按钮动作 | "" |
| `-b2` | `--button2` | 第二个按钮文本 | "" |
| `-a2` | `--action2` | 第二个按钮动作 | "" |

## 📁 文件说明

| 文件 | 说明 |
|------|------|
| **核心功能** |  |
| `interactive-notify.sh` | 主通知脚本，支持所有参数和功能 |
| `toast-notify.ps1` | PowerShell BurntToast 核心实现 |
| `simple-notify.sh` | 简单消息框通知（降级方案） |
| `install-burnttoast.ps1` | BurntToast 模块安装脚本 |
| **Claude集成** |  |
| `claude-notify.sh` | Claude任务完成自动通知脚本 |
| `claude-shortcuts.sh` | Claude通知快捷函数库 |
| `claude-pause-notify.sh` | Claude暂停等待确认通知脚本 |
| `chabao-notify.sh` | 茶宝个性化通知脚本 |
| **测试工具** |  |
| `simple-test.bat` | Windows一键测试 |
| **资源文件** |  |
| `icons/` | 预设图标目录（success/warning/error/info + chabao.jpg） |
| **文档** |  |
| `README.md` | 完整使用文档（本文件） |
| `CLAUDE-INTEGRATION.md` | Claude集成指南 |

## 🎯 使用示例

### 1. 项目构建通知

```bash
# 构建开始
./interactive-notify.sh -t "项目构建" -m "开始编译..." -T info

# 构建成功（使用自定义图标和音效）
./interactive-notify.sh -t "构建完成" -m "编译成功，耗时 2分30秒" -T success \\
    -i icons/success.png -s Default \\
    -b1 "查看日志" -a1 "view-logs" \\
    -b2 "部署" -a2 "deploy"

# 构建失败（使用错误图标和告警音效）
./interactive-notify.sh -t "构建失败" -m "发现 3 个编译错误" -T error -d Long \\
    -i icons/error.png -s Alarm2 \\
    -b1 "查看错误" -a1 "view-errors"
```

### 2. 系统监控通知

```bash
# 性能警告（使用警告图标和提醒音效）
./interactive-notify.sh -t "性能告警" -m "CPU 使用率达到 85%" -T warning \\
    -i icons/warning.png -s Reminder \\
    -b1 "查看监控" -a1 "monitoring" \\
    -b2 "优化建议" -a2 "optimize"

# 服务异常（使用错误图标和循环告警）
./interactive-notify.sh -t "服务异常" -m "数据库连接丢失" -T error -d Long \\
    -i icons/error.png -s Alarm3 \\
    -b1 "重启服务" -a1 "restart" \\
    -b2 "查看日志" -a2 "logs"
```

### 3. 任务完成通知

```bash
# 数据处理完成（使用成功图标和邮件音效）
./interactive-notify.sh -t "数据处理" -m "客户报告已生成" -T success \\
    -i icons/success.png -s Mail \\
    -b1 "下载报告" -a1 "download" \\
    -b2 "发送邮件" -a2 "email"

# 备份完成（简单成功通知）
./interactive-notify.sh -t "备份完成" -m "数据库备份成功" -T success -i icons/success.png
```

### 4. 音效类型演示

```bash
# 邮件通知音效
./interactive-notify.sh -t "新邮件" -m "收到重要邮件" -s Mail

# IM即时消息音效  
./interactive-notify.sh -t "即时消息" -m "团队聊天消息" -s IM

# 提醒音效
./interactive-notify.sh -t "会议提醒" -m "10分钟后开会" -s Reminder

# 循环告警音效
./interactive-notify.sh -t "紧急情况" -m "需要立即处理" -s Alarm2 -d Long
```

### 5. Claude Code 自动通知

```bash
# Claude任务完成自动通知
./claude-notify.sh success "数据分析完成" "客户报表已生成"
./claude-notify.sh build "Maven构建" "项目编译成功"
./claude-notify.sh deploy "应用部署" "服务已上线"
./claude-notify.sh error "构建失败" "发现编译错误需要修复"

# 使用快捷函数（需要先source加载）
source ./claude-shortcuts.sh
claude_success "任务完成" "数据处理成功"
claude_build "前端构建" "React应用编译完成"  
claude_deploy "生产部署" "应用已发布到生产环境"
claude_error "测试失败" "发现单元测试错误"

# 暂停等待确认通知
claude_confirm "数据库操作" "即将删除测试数据，请确认"
claude_urgent "生产环境操作" "检测到生产环境操作，需要二次确认"
claude_pause "等待用户输入" "需要您提供配置参数" "important"
```

### 6. 个性化通知

```bash
# 茶宝专属通知（使用自定义图标）
./chabao-notify.sh "茶宝提醒" "该休息喝茶了"

# 预设的茶宝通知类型
./chabao-notify.sh work-break    # 工作休息提醒
./chabao-notify.sh task-done     # 任务完成庆祝
./chabao-notify.sh tea-time      # 下午茶时间
./chabao-notify.sh good-job      # 表扬奖励

# 自定义茶宝通知
./chabao-notify.sh "茶宝问候" "今天工作辛苦了" "success" "Default"
```

## 🔧 集成到项目

### Claude Code 项目集成

在项目的 `.claude/settings.local.json` 中添加：

```json
{
  "permissions": {
    "allow": [
      "Bash(<PROJECT_PATH>/interactive-notify.sh:*)",
      "Bash(<PROJECT_PATH>/claude-notify.sh:*)",
      "Bash(<PROJECT_PATH>/claude-shortcuts.sh:*)"
    ]
  },
  "additionalDirectories": [
    "<PROJECT_PATH>"
  ]
}
```

**Claude自动通知场景**：
- 📦 编译构建完成
- 🧪 测试执行完毕  
- 🚀 应用部署成功
- 📊 数据分析完成
- ❌ 遇到错误需要处理
- ✅ 任务成功完成

### Git Hook 集成

```bash
# post-commit hook
#!/bin/bash
./interactive-notify.sh -t "Git 提交" -m "代码已成功提交" -T success
```

### CI/CD 集成

```bash
# 构建脚本
mvn clean package
if [ $? -eq 0 ]; then
    ./interactive-notify.sh -t "CI/CD" -m "构建成功" -T success
else
    ./interactive-notify.sh -t "CI/CD" -m "构建失败" -T error
fi
```

## 🐛 故障排除

### BurntToast 模块未安装

```
ERROR: BurntToast module not available
```

**解决方案**：以管理员权限运行 `install-burnttoast.ps1`

### PowerShell 执行策略限制

```
execution of scripts is disabled on this system
```

**解决方案**：
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### 中文字符显示问题

Toast 通知中的中文可能显示为乱码，这是 WSL 和 PowerShell 之间编码转换的问题，不影响功能使用。

## 📜 版本历史

- **v1.0** - 基础通知功能
- **v1.1** - 添加交互按钮支持
- **v1.2** - 添加通知类型和音效支持
- **v1.3** - 添加降级机制和错误处理
- **v1.4** - 完善文档和安装脚本

## 📄 许可证

MIT License - 自由使用和修改

---

**🎉 享受智能的 Windows 通知体验！**