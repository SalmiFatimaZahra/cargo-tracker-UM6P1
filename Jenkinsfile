pipeline {
    agent any

    triggers {
        githubPush()
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/SalmiFatimaZahra/cargo-tracker-UM6P1'
            }
        }

        stage('Build & Test with Coverage') {
            steps {
                bat 'mvnw clean verify'
            }
        }

        stage('SonarQube Analysis') {
    steps {
        withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
            bat """
                mvnw sonar:sonar ^
                -Dsonar.projectKey=cargo-tracker ^
                -Dsonar.host.url=http://localhost:9000 ^
                -Dsonar.token=%SONAR_TOKEN%
            """
        }
    }
}

    post {
        success {
            echo 'Build et analyse terminés avec succès !'
        }
        failure {
            echo 'Échec du build ou des tests.'
        }
    }
}
