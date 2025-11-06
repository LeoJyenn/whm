## webhostmost救活脚本

用于CloudLinux环境中的Node.js应用恢复工具。此脚本可以帮助您快速清理和重建Node.js环境，解决环境损坏或配置错误的问题。

## 使用方法


###  运行脚本

```bash
curl -sSL https://raw.githubusercontent.com/LeoJyenn/whm/main/whm.sh | bash -s -- 用户名 域名

```

## 功能说明

- 清理销毁已有的Node.js环境
- 删除旧的nodevenv目录
- 创建全新的Node.js环境
- 自动安装npm依赖
- 清理npm日志
- 完成后自动删除脚本自身


