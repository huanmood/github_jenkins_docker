FROM python:3.10-slim

# 安装依赖
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    gnupg \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY web.py .

RUN pip install selenium

CMD ["python", "web.py"]