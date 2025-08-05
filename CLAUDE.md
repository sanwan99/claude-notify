# 🤖 CLAUDE.md - WSL Windows 交互式通知系统

## 📋 项目概述

这是一个专为 WSL 环境设计的 Windows Toast 通知系统，基于 BurntToast PowerShell 模块构建，支持自定义图标、音效和交互按钮。专门为 Claude Code 集成优化，提供智能任务完成通知功能。

**项目类型**: Bash/PowerShell 脚本工具集  
**环境**: WSL + Windows 10/11  
**语言**: 中文环境项目，支持 UTF-8 编码  

## 🚀 常用命令

### 安装和测试
```bash
# 安装 BurntToast 模块 (管理员权限运行)
powershell.exe -File install-burnttoast.ps1

# 设置执行权限
chmod +x *.sh

# 一键测试（Windows）
simple-test.bat

# WSL 完整功能测试
./test-enhanced-notifications.sh
```

### 基本通知命令
```bash
# 基本通知
./interactive-notify.sh -t "标题" -m "消息"

# 指定通知类型
./interactive-notify.sh -t "构建完成" -m "Maven编译成功" -T success

# 自定义图标和音效
./interactive-notify.sh -t "部署完成" -m "应用已发布" -i icons/success.png -s Mail

# 带交互按钮的通知
./interactive-notify.sh -t "报告生成" -m "点击查看详情" -T success \
    -b1 "查看报告" -a1 "open-report" \
    -b2 "发送邮件" -a2 "send-email"
```

### Claude 自动通知命令
```bash
# Claude 任务完成通知
./claude-notify.sh success "数据分析完成" "客户报表已生成"
./claude-notify.sh build "Maven构建" "项目编译成功"
./claude-notify.sh deploy "应用部署" "服务已上线"
./claude-notify.sh error "构建失败" "发现编译错误需要修复"

# 使用快捷函数（需要先 source）
source ./claude-shortcuts.sh
claude_success "任务完成" "数据处理成功"
claude_build "前端构建" "React应用编译完成"
claude_deploy "生产部署" "应用已发布到生产环境"
claude_error "测试失败" "发现单元测试错误"
```

## 🏗️ 项目架构

### 核心文件结构
```
<PROJECT_ROOT>/
├── 🔧 核心功能模块
│   ├── interactive-notify.sh      # 主通知脚本，支持全参数
│   ├── toast-notify.ps1          # PowerShell BurntToast 实现
│   ├── simple-notify.sh          # 降级方案（消息框）
│   └── install-burnttoast.ps1    # BurntToast 模块安装
├── 🤖 Claude 集成模块
│   ├── claude-notify.sh          # Claude 自动通知脚本
│   └── claude-shortcuts.sh       # Claude 快捷函数库
├── 🎨 资源文件
│   └── icons/                    # 预设图标库（success/warning/error/info）
├── 🧪 测试工具
│   ├── simple-test.bat           # Windows 一键测试
│   ├── menu-test.bat            # Windows 交互测试
│   └── test-enhanced-notifications.sh # WSL 完整测试
└── 📚 文档系统
    ├── README.md                 # 完整使用文档
    ├── USAGE.md                 # 快速使用指南
    ├── CLAUDE-INTEGRATION.md    # Claude 集成说明
    ├── PROJECT-SUMMARY.md       # 项目总结
    └── CLAUDE.md               # 本文件
```

### 架构设计模式

**分层架构**:
- **WSL 脚本层**: Bash 脚本处理参数和路径转换
- **PowerShell 执行层**: 调用 BurntToast 执行实际通知
- **降级处理层**: BurntToast 不可用时使用消息框

**功能模块化**:
- **通知类型系统**: info/success/warning/error 预设样式
- **自定义系统**: 支持自定义图标、音效、按钮
- **集成系统**: Claude Code 专用快捷接口

**核心业务逻辑**:
1. **参数解析和验证** (interactive-notify.sh:71-150)
2. **路径转换处理** - WSL 路径自动转换为 Windows 路径
3. **通知类型映射** - 根据类型自动选择图标、音效、颜色
4. **PowerShell 调用** - 编码处理和参数传递
5. **降级机制** - BurntToast 失败时使用消息框

### 集成点

- **Claude Code 权限配置**: 需要在 `.claude/settings.local.json` 中配置权限
- **Git Hooks 集成**: 支持 post-commit 等钩子集成
- **CI/CD 集成**: 可集成到构建脚本中
- **跨平台路径处理**: WSL 和 Windows 路径自动转换

## 🔄 标准工作流程

### 开发流程
1. **分析问题**: 确定通知需求（类型、样式、交互）
2. **选择方案**: 
   - 简单通知 → `interactive-notify.sh`
   - Claude 集成 → `claude-notify.sh` 或快捷函数
   - 自定义需求 → 完整参数调用
3. **测试验证**: 使用测试脚本验证功能
4. **集成部署**: 配置权限和路径

### Claude 自动通知工作流程
1. **任务执行**: Claude 执行用户请求的任务
2. **智能分类**: 根据任务类型自动选择合适的通知样式
3. **自动调用**: 调用相应的通知脚本
4. **用户提醒**: Windows Toast 通知提醒用户任务完成

### 开发原则
- **简单优先**: 优先使用预设类型，避免过度自定义
- **错误处理**: 确保降级机制正常工作
- **路径安全**: 正确处理 WSL 和 Windows 路径转换
- **编码兼容**: 支持中文字符显示

## ⚙️ 环境配置

### 系统要求
- **操作系统**: Windows 10/11 + WSL
- **PowerShell**: 版本 5.1 或更高
- **BurntToast**: PowerShell 模块（自动安装）
- **权限**: PowerShell 执行权限

### 安装步骤
1. 运行 `install-burnttoast.ps1`（管理员权限）
2. 设置脚本执行权限 `chmod +x *.sh`
3. 运行 `simple-test.bat` 验证安装

### Claude Code 集成配置
在项目根目录创建 `.claude/settings.local.json`:
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

## 🎯 通知类型系统

### 预设通知类型
| 类型 | 图标 | 音效 | 颜色 | 使用场景 |
|------|------|------|------|----------|
| `info` | 蓝色 i | SMS | 蓝色 | 一般信息通知 |
| `success` | 绿色 ✓ | Default | 绿色 | 任务成功完成 |
| `warning` | 黄色 ⚠ | Reminder | 黄色 | 警告和注意事项 |
| `error` | 红色 ✗ | Alarm2 | 红色 | 错误和失败 |

### Claude 专用类型
| 类型 | 说明 | 图标 | 音效 |
|------|------|------|------|
| `build` | 构建完成 | 绿色 ✓ | Default |
| `test` | 测试完成 | 蓝色 i | SMS |
| `deploy` | 部署完成 | 绿色 ✓ | Mail |

## 🔧 重要说明和最佳实践

### 使用建议
- **任务完成通知**: 重要任务完成时使用 `success` 类型
- **错误处理**: 错误发生时使用 `error` 类型并设置长时间显示
- **日常提醒**: 定期任务使用 `info` 类型避免干扰
- **紧急情况**: 使用循环告警音效 (`Alarm2`, `Alarm3`)

### 性能优化
- **图标缓存**: 图标文件放在 `icons/` 目录下重复使用
- **路径优化**: 使用绝对路径避免路径解析开销
- **降级处理**: BurntToast 不可用时自动使用消息框

### 故障排除
- **BurntToast 未安装**: 运行 `install-burnttoast.ps1`
- **执行策略限制**: 设置 `Set-ExecutionPolicy RemoteSigned`
- **中文字符问题**: 使用 UTF-8 编码，确保脚本正确设置 `chcp 65001`
- **权限问题**: 确保 Claude 权限配置正确

### 安全注意事项
- **脚本执行权限**: 仅允许可信脚本执行
- **路径验证**: 自动验证和转换路径
- **参数过滤**: 防止恶意参数注入

### Claude 集成最佳实践
- **自动分类**: 让 Claude 根据任务类型自动选择通知样式
- **简化调用**: 优先使用快捷函数而非直接调用
- **错误反馈**: 重要错误使用长时间显示和告警音效
- **成功确认**: 重要任务完成使用自定义音效确认

## 🚨 Claude 常用通知模式

### 任务完成模式
```bash
# 数据分析完成
claude_success "数据分析完成" "客户报表已生成，包含 ${count} 条记录"

# 代码生成完成
claude_success "代码生成完成" "${filename} 已创建，包含 ${lines} 行代码"
```

### 构建部署模式
```bash
# 构建成功
claude_build "项目构建成功" "Maven 编译完成，耗时 ${duration}"

# 部署完成
claude_deploy "应用部署完成" "服务已成功发布到 ${environment} 环境"
```

### 错误处理模式
```bash
# 构建失败
claude_error "构建失败" "发现 ${error_count} 个编译错误，需要修复"

# 测试失败
claude_error "测试失败" "${failed_tests} 个测试用例失败，请检查代码"
```

---

**🎯 Claude Code 集成要点**: 
- Claude 完成任务后会自动调用相应的通知函数
- 通知样式会根据任务类型智能选择
- 重要任务建议使用长时间显示和自定义音效
- 所有通知都支持中文显示，编码已优化处理

**📞 快速支持**: 如有问题，可查看完整文档 `README.md` 或集成指南 `CLAUDE-INTEGRATION.md`

## 🔔 自动通知规则

### 任务完成时自动通知
当我完成以下任务时，会自动发送通知：

1. **代码任务完成**：
   ```bash
   /mnt/e/wsl/claude-notify/claude-notify.sh success "任务完成" "具体描述"
   ```

2. **遇到错误时**：
   ```bash
   /mnt/e/wsl/claude-notify/claude-notify.sh error "任务失败" "错误描述"
   ```

3. **需要确认时**：
   ```bash
   /mnt/e/wsl/claude-notify/claude-notify.sh warning "需要确认" "操作描述"
   ```