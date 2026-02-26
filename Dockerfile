# ---------- 基础镜像 ----------
FROM python:3.11-slim-bullseye

# ---------- 设置国内源 ----------
RUN sed -i 's|http://deb.debian.org/debian|http://mirrors.tuna.tsinghua.edu.cn/debian|g' /etc/apt/sources.list \
    && sed -i 's|http://security.debian.org/debian-security|http://mirrors.tuna.tsinghua.edu.cn/debian-security|g' /etc/apt/sources.list

# ---------- 安装系统依赖与 Chromium ----------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        curl \
        unzip \
        gnupg \
        chromium \
        chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# ---------- 设置环境变量 ----------
# Chromium 可执行路径
ENV CHROME_BIN=/usr/bin/chromium
ENV CHROMEDRIVER_BIN=/usr/bin/chromedriver

# ---------- 安装 Python 包 ----------
# 如果你有 requirements.txt，可以 COPY 进来
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# ---------- 工作目录 ----------
WORKDIR /app

# ---------- 复制代码 ----------
COPY . /app

# ---------- 默认命令（可改成你自己的脚本） ----------
# 例如你的 web.py 文件
CMD ["python", "web.py"]