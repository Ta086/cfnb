#!/bin/bash
# git_sync.sh
# 功能：将当前目录下的 ip.txt 文件强制推送到 GitHub 仓库的指定分支
# 使用场景：配合 Cloudflare IP 优选工具，自动同步优选结果到远程仓库
#
# ⚠️ 安全提醒：Token 应从环境变量或配置文件读取，不要硬编码在脚本中！

# ==================== GitHub 认证信息 ====================
# 从环境变量读取 token（更安全）
# 使用方式：export GITHUB_TOKEN="your_token" 后再运行脚本
if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ 错误：GITHUB_TOKEN 环境变量未设置"
    echo "请先运行：export GITHUB_TOKEN='your_personal_access_token'"
    exit 1
fi

# GitHub 用户名
github_username="Ta086"
# 仓库名称
repo_name="cfnb"
# 目标分支
branch="main"

# ==================== 切换到脚本所在目录 ====================
cd "$(dirname "$0")" || exit 1

# ==================== 拉取远程最新更新 ====================
git pull origin "$branch"

# ==================== 暂存并提交 ip.txt ====================
git add ip.txt
commit_msg="Update ip.txt on $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$commit_msg"

# ==================== 强制推送到 GitHub ====================
git push "https://${GITHUB_TOKEN}@github.com/${github_username}/${repo_name}.git" "$branch" --force

echo "✅ ip.txt 已推送到 GitHub"
