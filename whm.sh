#!/bin/bash
set -e

# 从命令行参数获取输入
INPUT_USERNAME=$1
INPUT_DOMAIN=$2

# 参数检查
if [ -z "$INPUT_USERNAME" ]; then
    echo "错误：未输入用户名。脚本将退出。"
    exit 1
fi

if [ -z "$INPUT_DOMAIN" ]; then
    echo "错误：未输入域名。脚本将退出。"
    exit 1
fi

echo "将使用以下信息执行脚本："
echo "用户名: $INPUT_USERNAME"
echo "域名: $INPUT_DOMAIN"
echo ""

APP_PUBLIC_HTML_SUBDIR="public_html"
NODE_SELECTOR_VERSION="22.14.0"
NODE_ENV_PATH_VERSION="22" 
APP_STARTUP_FILE="index.js"

APP_ROOT_DIRECTORY="/home/${INPUT_USERNAME}/domains/${INPUT_DOMAIN}/${APP_PUBLIC_HTML_SUBDIR}"
NPM_COMMAND_PATH="/home/${INPUT_USERNAME}/nodevenv/domains/${INPUT_DOMAIN}/${APP_PUBLIC_HTML_SUBDIR}/${NODE_ENV_PATH_VERSION}/bin/npm"
NPM_LOG_DIRECTORY="/home/${INPUT_USERNAME}/.npm/_logs"

# 先销毁可能存在的旧环境
cloudlinux-selector destroy \
    --json \
    --interpreter=nodejs \
    --user="$INPUT_USERNAME" \
    --app-root="$APP_ROOT_DIRECTORY"

# 删除旧的nodevenv目录
rm -rf /home/${INPUT_USERNAME}/nodevenv/domains/${INPUT_DOMAIN}

# 创建新环境
cloudlinux-selector create \
    --json \
    --interpreter=nodejs \
    --user="$INPUT_USERNAME" \
    --app-root="$APP_ROOT_DIRECTORY" \
    --app-uri="/" \
    --version="$NODE_SELECTOR_VERSION" \
    --app-mode="development" \
    --startup-file="$APP_STARTUP_FILE"

# 安装依赖
if [ -d "$APP_ROOT_DIRECTORY" ] && [ -f "$NPM_COMMAND_PATH" ] && [ -x "$NPM_COMMAND_PATH" ]; then
    (
        cd "$APP_ROOT_DIRECTORY" && "$NPM_COMMAND_PATH" install
    )
    echo "依赖安装完成。"
else
    echo "安装失败。"
fi

# 清理日志
if [ -d "$NPM_LOG_DIRECTORY" ]; then
    rm -f "${NPM_LOG_DIRECTORY}/"*.log
    echo "已删除日志。"
else
    echo "日志目录 '${NPM_LOG_DIRECTORY}' 不存在。"
fi

echo "执行成功。"
