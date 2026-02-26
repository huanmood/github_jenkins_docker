# Dockerfile

# 使用官方 Python 3.11 slim 镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 拷贝代码
COPY . /app

# 安装依赖
RUN pip install --no-cache-dir flask

# 暴露端口
EXPOSE 8080

# 容器启动命令
CMD ["python", "web.py"]