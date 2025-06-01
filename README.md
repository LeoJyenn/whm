# WHM Node.js 自动部署脚本

这是一个用于在 cPanel/WHM 服务器上自动配置 Node.js 应用程序的脚本。脚本通过 CloudLinux Selector 创建 Node.js 应用环境，并执行必要的设置步骤。

## 功能

- 自动创建 Node.js 应用环境
- 配置应用程序的根目录和启动文件
- 自动安装依赖包
- 清理安装日志
- 完成后自动清理脚本自身

## 使用方法

### 1. 下载脚本

将脚本下载到用户的主目录：

```bash
wget -O ~/whm.sh https://raw.githubusercontent.com/用户名/whm/main/whm.sh
```

### 2. 设置执行权限

```bash
chmod +x ~/whm.sh
```

### 3. 运行脚本

```bash
./whm.sh
```

### 4. 按提示输入信息

脚本运行后会要求您输入：
- 用户名
- 域名

然后脚本将自动完成所有配置工作。

## 系统要求

- CloudLinux 操作系统
- cPanel/WHM 控制面板
- 已经配置好的 Node.js Selector

## 注意事项

- 脚本默认使用 Node.js 版本 22.14.0
- 应用程序入口文件默认为 index.js
- 脚本执行完毕后会自动删除自身 