#!/bin/bash
# 用法: ./deploy.sh <github用户名> [仓库名]
# 仓库名默认 用户名.github.io（个人主页）
set -e
USER_NAME="$1"
REPO_NAME="${2:-$USER_NAME.github.io}"
[ -z "$USER_NAME" ] && { echo "缺少 GitHub 用户名"; exit 1; }
cd "$(dirname "$0")"
git init -q 2>/dev/null || true
git config user.name "zhang.xianlin"
git config user.email "zhang.xianlin@marvel-tech.net"
git config core.sshCommand "ssh -i $HOME/.ssh/id_ed25519_marvel -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new"
git add -A
git commit -q -m "慢游科技系统案例介绍 9 系统" 2>/dev/null || echo "无新改动"
git branch -M main
if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "git@github.com:$USER_NAME/$REPO_NAME.git"
else
  git remote add origin "git@github.com:$USER_NAME/$REPO_NAME.git"
fi
git push -u origin main
echo "推送完成：https://github.com/$USER_NAME/$REPO_NAME"
