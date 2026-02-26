pipeline {
    agent any

    environment {
        SSH_KEY = "C:\\Users\\YZY\\.ssh\\id_rsa"
        REMOTE_USER = "root"
        REMOTE_HOST = "10.103.196.119"
        REMOTE_DIR = "/root/jenkins_build"
        APP_NAME = "myapp"
        DOCKER_PORT = "8080"
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Jenkins 自己拉最新代码
                git branch: 'main', url: 'https://github.com/huanmood/huan.git'
            }
        }

        stage('Copy Code to Linux & Build Docker') {
            steps {
                bat """
                scp -r -i "%SSH_KEY%" * %REMOTE_USER%@%REMOTE_HOST%:%REMOTE_DIR%
                
                ssh -i "%SSH_KEY%" -o StrictHostKeyChecking=no %REMOTE_USER%@%REMOTE_HOST% "
                    cd %REMOTE_DIR% &&
                    docker build -t %APP_NAME%:latest .
                "
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                bat """
                ssh -i "%SSH_KEY%" -o StrictHostKeyChecking=no %REMOTE_USER%@%REMOTE_HOST% "
                    docker stop %APP_NAME% || true &&
                    docker rm %APP_NAME% || true &&
                    docker run -d --name %APP_NAME% -p %DOCKER_PORT%:8080 %APP_NAME%:latest
                "
                """
            }
        }
    }
}