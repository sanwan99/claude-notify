# 📁 通知图标资源库

此目录用于存放通知系统的图标文件。

## 🎨 当前图标

### 系统预设图标
- `success.png` - 成功/完成图标 (绿色对勾)
- `warning.png` - 警告图标 (黄色三角感叹号)
- `error.png` - 错误图标 (红色X或感叹号)
- `info.png` - 信息图标 (蓝色i或问号)

### 🍵 个人定制图标
- `chabao.jpg` - 茶宝专属图标 (个性化通知)

## 📝 使用方法

```bash
# 使用系统预设图标
./interactive-notify.sh -t "成功" -m "操作完成" -i icons/success.png

# 使用茶宝个人图标
./chabao-notify.sh "茶宝提醒" "该喝茶了"

# 使用绝对路径自定义图标
./interactive-notify.sh -t "警告" -m "注意事项" -i /path/to/custom/icon.png
```

## 🔄 快速更换个人图标

### 更换茶宝图标
```bash
# 方法1: 直接替换文件
cp "/path/to/new/image.jpg" "<PROJECT_ROOT>/icons/chabao.jpg"

# 方法2: 修改脚本路径 (在chabao-notify.sh中)
CHABAO_ICON="/path/to/your/image.jpg"
```

### 添加新的个人图标
```bash
# 拷贝到icons目录
cp "/path/to/personal.png" "<PROJECT_ROOT>/icons/personal.png"

# 在脚本中使用
./interactive-notify.sh -i "icons/personal.png" -t "个人提醒" -m "自定义消息"
```

## 🛠️ 图标规格建议

- **格式**: PNG, JPG, ICO
- **尺寸**: 64x64 像素 (推荐)
- **背景**: 透明背景 (PNG格式)
- **风格**: 简洁、清晰的图标设计

## 添加自定义图标

1. 将图标文件复制到此目录
2. 确保文件名简洁明了
3. 推荐使用PNG格式以支持透明背景
4. 在通知脚本中使用相对路径引用

## 在线图标资源

- [Feather Icons](https://feathericons.com/) - 简洁的线性图标
- [Material Icons](https://fonts.google.com/icons) - Google Material Design图标
- [Heroicons](https://heroicons.com/) - 简洁的SVG图标
- [Tabler Icons](https://tabler-icons.io/) - 免费的SVG图标

**注意**: 使用在线图标时请注意版权和使用许可。