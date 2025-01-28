pipeline {
    agent any

    environment {
        // Définir les credentials pour Docker Hub
        DOCKER_USERNAME = credentials('dockerhub-credentials') // Nom des credentials Docker Hub
        DOCKER_IMAGE = "${DOCKER_USERNAME}/testspringcicdjenkins-app:latest"
    }

    tools {
        maven 'Maven3' // Maven configuré dans Jenkins Global Tool Configuration
    }

    stages {
        stage('Check Tools') {
            steps {
                echo "Vérification des outils Maven et Docker..."
                sh 'mvn -v' // Vérifie Maven
                sh 'docker -v' // Vérifie Docker
            }
        }

        stage('Checkout Code') {
            steps {
                echo "Clonage du dépôt GitHub..."
                checkout scm
            }
        }

        stage('Build Maven Project') {
            steps {
                echo "Construction du projet Spring Boot avec Maven..."
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Construction de l'image Docker..."
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Poussée de l'image Docker sur Docker Hub..."
                sh '''
                echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                docker push $DOCKER_IMAGE
                '''
            }
        }

        stage('Deploy Application') {
            steps {
                echo "Déploiement de l'application Spring Boot..."
                sh 'docker run -d -p 3000:3000 $DOCKER_IMAGE'
            }
        }
    }

    post {
        always {
            echo "Nettoyage des ressources inutilisées..."
            sh 'docker system prune -f'
        }
        success {
            echo "Pipeline exécuté avec succès 🎉"
        }
        failure {
            echo "Échec du pipeline. Vérifiez les journaux pour les erreurs."
        }
    }
}
