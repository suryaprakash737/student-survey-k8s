pipeline {
    agent any
    
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKER_IMAGE = 'suryaprakash737/student-survey'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                sh "docker tag ${DOCKER_IMAGE}:${BUILD_NUMBER} ${DOCKER_IMAGE}:latest"
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing to Docker Hub...'
                sh "echo \$DOCKER_HUB_CREDENTIALS_PSW | docker login -u \$DOCKER_HUB_CREDENTIALS_USR --password-stdin"
                sh "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                sh "docker push ${DOCKER_IMAGE}:latest"
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying to K3s...'
                sh "kubectl apply -f k8s-deployment.yaml"
                sh "kubectl rollout restart deployment/student-survey-deployment -n student-survey"
                sh "kubectl get pods -n student-survey"
            }
        }
    }
    
    post {
        always {
            sh 'docker logout'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}