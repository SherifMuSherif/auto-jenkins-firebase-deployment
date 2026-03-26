pipeline {
    agent any

    environment {
        FIREBASE_TOKEN = credentials('FIREBASE_TOKEN')
    }

    stages {
        stage('Checkout') {
            steps {
                // Jenkins checks out code automatically for Pipeline jobs
                // configured with SCM, but we add this for clarity
                checkout scm
            }
        }

        stage('Verify Tools') {
            steps {
                sh 'node --version'
                sh 'npm --version'
                sh 'firebase --version'
            }
        }

        stage('Deploy to Firebase') {
            steps {
                sh "firebase deploy --only hosting --token \$FIREBASE_TOKEN"
            }
        }
    }

    post {
        success {
            echo 'Deployment successful! Your site is live on Firebase.'
        }
        failure {
            echo 'Deployment failed. Check the logs above for errors.'
        }
    }
}