pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'submain', url: 'https://github.com/your-repo-path/github-actions-for-desktop-apps.git'
            }
        }

        stage('Build') {
            steps {
                sh './gradlew build'
            }
        }

        stage('Unit Test') {
            steps {
                sh './gradlew test'
            }
        }

        stage('Docker Build') {
            steps {
                
                sh 'docker build -t github-actions-for-desktop-apps:1.0 .'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true
            junit 'build/test-results/test/*.xml'
        }   
        success {
            echo 'Build and Tests Successful!'
        }
        failure {
            echo 'Something failed.'
        }
    }
}
