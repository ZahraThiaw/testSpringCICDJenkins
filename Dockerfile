# Étape 1 : Utiliser une image officielle JDK comme base
FROM openjdk:21-jdk-slim

# Étape 2 : Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Étape 3 : Copier le fichier JAR généré
COPY target/testSpringCICDJenkins-0.0.1-SNAPSHOT.jar app.jar

# Étape 4 : Exposer le port utilisé par l'application Spring Boot
EXPOSE 3000

# Étape 5 : Commande pour lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
