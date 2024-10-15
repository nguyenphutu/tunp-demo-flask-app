pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                git 'https://github.com/username/flask_app.git'
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
