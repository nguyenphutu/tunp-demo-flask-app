pipeline {
    agent {
        docker { image 'python:3.9-slim' }
    }

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

        stage('Deploy') {
            steps {
                script {
                    dockerImage.run('-d -p 5000:5000 flask-app')
                }
            }
        }
    }
}
