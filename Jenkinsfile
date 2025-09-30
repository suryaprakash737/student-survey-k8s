pipeline {
    agent any
    
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKER_IMAGE_NAME = 'suryaprakash737/student-survey'
        DOCKER_IMAGE_TAG = "${BUILD_NUMBER}"
        KUBECONFIG_CREDENTIALS = credentials('kubeconfig')
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
                    docker.build("${DOCKER_IMAGE_NAME}:latest")
                }
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                script {
                    // Run basic container test
                    sh """
                        docker run -d --name test-container -p 8081:80 ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
                        sleep 5
                        curl -f http://localhost:8081 || exit 1
                        docker stop test-container
                        docker rm test-container
                    """
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing Docker image to Docker Hub...'
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                        docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}").push()
                        docker.image("${DOCKER_IMAGE_NAME}:latest").push()
                    }
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying to Kubernetes...'
                script {
                    sh """
                        # Update the image in deployment
                        sed -i 's|image: .*|image: ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}|g' kubernetes-deployment.yaml
                        
                        # Apply Kubernetes configuration
                        kubectl apply -f kubernetes-deployment.yaml
                        
                        # Wait for rollout to complete
                        kubectl rollout status deployment/student-survey-deployment
                        
                        # Verify deployment
                        kubectl get pods -l app=student-survey
                        kubectl get service student-survey-service
                    """
                }
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline executed successfully!'
            emailext(
                subject: "Jenkins Build Success: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "The build was successful. Check console output at ${env.BUILD_URL}",
                to: 'suryaprakashu55@gmail.com'
            )
        }
        failure {
            echo 'Pipeline failed!'
            emailext(
                subject: "Jenkins Build Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "The build failed. Check console output at ${env.BUILD_URL}",
                to: 'your-email@example.com'
            )
        }
        always {
            // Clean up
            sh 'docker system prune -f'
        }
    }
}