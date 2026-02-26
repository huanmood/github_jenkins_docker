pipeline {
    agent any
    
    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/huanmood/github_jenkins_docker.git'
            }
        }
        
        stage('Copy Code to Linux & Build Docker') {
            steps {
                bat '''
                    ssh -i "C:\\Users\\YZY\\.ssh\\id_rsa" root@10.103.196.119 "mkdir -p /root/jenkins_build"
                    scp -r -i "C:\\Users\\YZY\\.ssh\\id_rsa" * root@10.103.196.119:/root/jenkins_build/
                    ssh -i "C:\\Users\\YZY\\.ssh\\id_rsa" root@10.103.196.119 "cd /root/jenkins_build && docker build -t simple_app:latest ."
                '''
            }
        }
        
        stage('Run Docker Container') {
            steps {
                bat '''
                    ssh -i "C:\\Users\\YZY\\.ssh\\id_rsa" root@10.103.196.119 "
                        docker stop simple_app 2>/dev/null || true &&
                        docker rm simple_app 2>/dev/null || true &&
                        docker run -d --name simple_app -p 5000:5000 simple_app:latest
                    "
                '''
            }
        }
    }
}