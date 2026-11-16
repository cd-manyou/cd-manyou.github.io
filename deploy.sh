#!/bin/bash
# 更新线上站点：先在 系统案例介绍/ 下重跑 build_web.py，再同步到本目录后执行本脚本
# 用法: GH_TOKEN=xxx ./deploy.sh
set -e
[ -z "$GH_TOKEN" ] && { echo "需要 GH_TOKEN 环境变量"; exit 1; }
cd "$(dirname "$0")"
git config user.name "cd-manyou"
git config user.email "zhang.xianlin@marvel-tech.net"
git add -A
git commit -q -m "更新案例册内容" 2>/dev/null || echo "无新改动"
git push "https://x-access-token:$GH_TOKEN@github.com/cd-manyou/cd-manyou.github.io.git" main
echo "已发布：https://cd-manyou.github.io/"
