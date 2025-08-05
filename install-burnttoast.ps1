# BurntToast PowerShell 模块安装脚本
# 需要以管理员权限运行

Write-Host "🚀 开始安装 BurntToast PowerShell 模块..." -ForegroundColor Green

# 检查是否已安装
$installed = Get-Module -ListAvailable -Name BurntToast
if ($installed) {
    Write-Host "✅ BurntToast 模块已安装，版本: $($installed.Version)" -ForegroundColor Yellow
    Write-Host "   位置: $($installed.ModuleBase)"
} else {
    Write-Host "📦 正在安装 BurntToast 模块..." -ForegroundColor Cyan
    
    try {
        # 设置 PowerShell Gallery 为可信任源（如果需要）
        if ((Get-PSRepository -Name PSGallery).InstallationPolicy -ne 'Trusted') {
            Write-Host "🔒 设置 PowerShell Gallery 为可信任源..."
            Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
        }
        
        # 安装 BurntToast 模块
        Install-Module -Name BurntToast -Force -AllowClobber
        
        Write-Host "✅ BurntToast 模块安装成功！" -ForegroundColor Green
        
        # 验证安装
        Import-Module BurntToast
        $version = (Get-Module BurntToast).Version
        Write-Host "   版本: $version" -ForegroundColor Green
        
        # 发送测试通知
        Write-Host "🔔 发送测试通知..." -ForegroundColor Cyan
        New-BurntToastNotification -Text @("安装成功", "BurntToast 模块已成功安装并可以使用！") -Sound "Default"
        
    } catch {
        Write-Host "❌ 安装失败: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "请确保以管理员权限运行此脚本" -ForegroundColor Yellow
        exit 1
    }
}

Write-Host ""
Write-Host "📚 使用说明:" -ForegroundColor Cyan
Write-Host "1. 运行交互式通知: ./interactive-notify.sh -t '标题' -m '消息'"
Write-Host "2. 查看帮助信息: ./interactive-notify.sh --help"
Write-Host "3. 运行演示脚本: ./test-notifications.sh"
Write-Host ""
Write-Host "🎉 BurntToast 环境配置完成！" -ForegroundColor Green