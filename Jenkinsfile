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
 
        stage('Copy Code to Linux & Build Docker') {
            steps {
             bat """
	ssh -i "%SSH_KEY%" %REMOTE_USER%@%REMOTE_HOST% "mkdir -p %REMOTE_DIR%"
	scp -r -i "%SSH_KEY%" * %REMOTE_USER%@%REMOTE_HOST%:%REMOTE_DIR%
	ssh -i "%SSH_KEY%" %REMOTE_USER%@%REMOTE_HOST% "cd %REMOTE_DIR% && docker build -t 	github_jenkins_docker:latest ."
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