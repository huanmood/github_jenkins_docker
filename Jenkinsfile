pipeline {
    agent any

    environment {
        REMOTE_USER = "root"
        REMOTE_HOST = "10.103.196.119"
        REMOTE_DIR  = "/root/jenkins_build"
        IMAGE_NAME  = "simple_app"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/huanmood/github_jenkins_docker.git', branch: 'main'
            }
        }

        stage('Copy Code to Linux & Build Docker') {
            steps {
                bat """
                ssh -i "C:\\Users\\YZY\\.ssh\\id_rsa" %REMOTE_USER%@%REMOTE_HOST% "mkdir -p %REMOTE_DIR%"
                scp -r -i "C:\\Users\\YZY\\.ssh\\id_rsa" * %REMOTE_USER%@%REMOTE_HOST%:%REMOTE_DIR%
                ssh -i "C:\\Users\\YZY\\.ssh\\id_rsa" %REMOTE_USER%@%REMOTE_HOST% " cd %REMOTE_DIR% && docker build -t %IMAGE_NAME%:latest .
                "
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                bat """
                ssh -i "C:\\Users\\YZY\\.ssh\\id_rsa" %REMOTE_USER%@%REMOTE_HOST% "
                    docker stop %IMAGE_NAME% || true &&
                    docker rm %IMAGE_NAME% || true &&
                    docker run -d --name %IMAGE_NAME% -p 8080:8080 %IMAGE_NAME%:latest
                "
                """
            }
        }
    }
}