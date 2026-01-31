# ====== Stage 1: Build frontend ======
FROM node:20-bullseye AS builder
WORKDIR /app

# 安装依赖
COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm
RUN pnpm install

# 复制项目文件并构建
COPY . .
RUN pnpm build

# ====== Stage 2: Nginx ======
FROM nginx:alpine
# 清空默认网站
RUN rm -rf /usr/share/nginx/html/*

# 复制构建好的静态文件到 Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# 如果你有自定义 Nginx 配置
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

