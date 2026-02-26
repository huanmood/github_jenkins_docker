# 使用官方 Python 3.11 slim 镜像
FROM python:latest

# 设置工作目录
WORKDIR /app

# 复制代码到容器
COPY web.py /app/

# 安装 Flask
RUN pip install --no-cache-dir flask

# 暴露端口
EXPOSE 5000

# 启动服务
CMD ["python", "web.py"]