pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                git 'https://github.com/nguyenphutu/tunp-demo-flask-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("flask-app")
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    dockerImage.inside {
                        sh 'pytest tests/'
                    }
                }
            }
        }
        stage('Stop and Remove Existing Container') {
            steps {
                script {
                    // Stop and remove the existing Flask container
                    sh '''
                    if [ "$(docker ps -q -f name=flask-app)" ]; then
                        docker stop flask-app
                        docker rm flask-app
                    fi
                    '''
                }
            }
        }
        stage('Run New Container') {
            steps {
                script {
                    // Run the new container
                    sh 'docker run -d -p 5000:5000 --name flask-app flask-app:latest'
                }
            }
        }
    }
}
