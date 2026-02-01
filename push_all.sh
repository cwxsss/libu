#!/bin/bash
set -e

# =========================
# 配置
# =========================
GITHUB_USER="cwxsss"
GITHUB_REPO="libu"
GITHUB_BRANCH="main"

DOCKERHUB_USER="suzier"
DOCKER_IMAGE="libu"
DOCKER_TAG="latest"

# =========================
# 推送代码到 GitHub
# =========================
echo "📦 正在推送代码到 GitHub..."
git add .
git commit -m "Auto commit: $(date '+%Y-%m-%d %H:%M:%S')" || echo "没有新的更改"
git push https://$GITHUB_USER@github.com/$GITHUB_USER/$GITHUB_REPO.git $GITHUB_BRANCH --force

# =========================
# 构建 Docker 镜像
# =========================
echo "🐳 正在构建 Docker 镜像..."
docker build -t $DOCKERHUB_USER/$DOCKER_IMAGE:$DOCKER_TAG .

# =========================
# 登录 Docker Hub
# =========================
echo "🔑 请登录 Docker Hub..."
docker login

# =========================
# 推送 Docker 镜像
# =========================
echo "🚀 正在推送 Docker 镜像到 Docker Hub..."
docker push $DOCKERHUB_USER/$DOCKER_IMAGE:$DOCKER_TAG

echo "✅ 所有操作完成！GitHub 和 Docker Hub 都已更新。"

