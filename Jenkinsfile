pipeline {
    agent any

    environment {
        REMOTE_USER = "root"
        REMOTE_HOST = "10.103.196.119"
        REMOTE_DIR  = "/root/jenkins_build"
        SSH_KEY     = "C:\\Users\\YZY\\.ssh\\id_rsa"
        IMAGE_NAME  = "simple_app:latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                // 拉取最新代码
                git url: 'https://github.com/huanmood/github_jenkins_docker.git', branch: 'main'
            }
        }

        stage('Copy Code to Linux & Build Docker') {
            steps {
                bat """
                ssh -i "${SSH_KEY}" ${REMOTE_USER}@${REMOTE_HOST} "mkdir -p ${REMOTE_DIR}"
                scp -r -i "${SSH_KEY}" * ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}
                ssh -i "${SSH_KEY}" ${REMOTE_USER}@${REMOTE_HOST} "cd ${REMOTE_DIR} && docker build -t ${IMAGE_NAME} ."
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                bat """
                ssh -i "${SSH_KEY}" ${REMOTE_USER}@${REMOTE_HOST} "
                    docker stop simple_app || true &&
                    docker rm simple_app || true &&
                    docker run -d --name simple_app -p 5000:5000 ${IMAGE_NAME}
                "
                """
            }
        }
    }
}