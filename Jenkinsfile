pipeline {
    agent any
    environment {
        TELEGRAM_TOKEN = '7799067201:AAEOMDltsWiVAzStFDRz3_C-y4JTE0KAiZQ'
        TELEGRAM_CHAT_ID = '-4545546419'
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
                        // Đảm bảo đúng đường dẫn tới thư mục tests
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
    post {
        success {
            script {
                sendTelegramMessage("✅ *Build Successful*\n\n" +
                                    "*Job Name:* ${env.JOB_NAME}\n" +
                                    "*Build Number:* ${env.BUILD_NUMBER}\n" +
                                    "*Branch:* ${env.GIT_BRANCH}\n" +
                                    "*Build URL:* ${env.BUILD_URL}\n" +
                                    "*Duration:* ${currentBuild.durationString}")
            }
        }
        failure {
            script {
                sendTelegramMessage("❌ *Build Failed*\n\n" +
                                    "*Job Name:* ${env.JOB_NAME}\n" +
                                    "*Build Number:* ${env.BUILD_NUMBER}\n" +
                                    "*Branch:* ${env.GIT_BRANCH}\n" +
                                    "*Build URL:* ${env.BUILD_URL}\n" +
                                    "*Duration:* ${currentBuild.durationString}")
            }
        }
    }
}

def sendTelegramMessage(String message) {
    sh """
    curl -s -X POST https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage \\
    -d chat_id=${TELEGRAM_CHAT_ID} \\
    -d text="${message}"
    """
}
