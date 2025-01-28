pipeline {
    agent any
    environment {
        // Utilisez les credentials configurés dans Jenkins pour Docker Hub
        DOCKER_USERNAME = credentials('dockerhub-credentials') // Nom des credentials Docker Hub
        DOCKER_IMAGE = "${DOCKER_USERNAME}/testspringcicdjenkins-app:latest" // Nom de l'image Docker
    }
    stages {
        stage('Checkout Code') {
            steps {
                echo "Clonage du dépôt GitHub..."
                checkout scm // Cloner automatiquement la branche en cours
            }
        }

        stage('Setup JDK 21') {
            steps {
                echo "Configuration de Java 21..."
                sh '''
                export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
                echo "JAVA_HOME configuré : $JAVA_HOME"
                '''
            }
        }

        stage('Build Maven Project') {
            steps {
                echo "Construction du projet Spring Boot avec Maven..."
                sh 'mvn clean package -DskipTests' // Construire le projet sans exécuter les tests
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Construction de l'image Docker..."
                sh '''
                docker build -t $DOCKER_IMAGE .
                '''
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
                // Lancer un conteneur Docker localement ou sur un serveur distant
                sh '''
                docker run -d -p 8080:8080 $DOCKER_IMAGE
                '''
            }
        }
    }

    post {
        always {
            echo "Pipeline terminé, nettoyage des ressources..."
            sh 'docker system prune -f' // Nettoyer les images Docker inutilisées
        }
        success {
            echo "Pipeline exécuté avec succès 🎉"
        }
        failure {
            echo "Échec du pipeline. Vérifiez les journaux de la console."
        }
    }
}
