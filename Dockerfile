# Étape 1 : Utilisation d'une image JDK comme base
FROM openjdk:21-jdk-slim

# Étape 2 : Définir le répertoire de travail
WORKDIR /app

# Étape 3 : Copier le JAR généré par Maven
COPY . .

# Étape 4 : Exposer le port utilisé par l'application
EXPOSE 3000

# Étape 5 : Commande pour lancer l'application
ENTRYPOINT ["java", "-jar", "target/testSpringCICDJenkins-O.0.1-SNAPSHOT.jar"]