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

        stage('Deploy') {
            steps {
                script {
                    dockerImage.run('-p 5000:5000 flask-app tunp-demo-flask-app')
                }
            }
        }
    }
}
