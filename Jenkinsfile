pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        // Si tu veux que le SONAR_TOKEN soit dispo partout, sinon laisse-le dans le stage ci-dessous
        // SONAR_TOKEN = credentials('sonar-token')
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/SalmiFatimaZahra/cargo-tracker-UM6P1'
            }
        }

        stage('Build & Test') {
            steps {
                bat 'mvn clean verify'
            }
        }

        stage('SonarQube Analysis') {
            environment {
                SONAR_TOKEN = credentials('sonar-token') // <-- Mets ici l'ID EXACT du secret Jenkins
            }
            steps {
                withSonarQubeEnv('SonarQube Local') {  // Correspond exactement au nom de ton serveur dans Jenkins > Manage Jenkins > Configure System > SonarQube servers
                    bat '''
                        mvn sonar:sonar ^
                        -Dsonar.projectKey=cargo-tracker ^
                        -Dsonar.projectName="Cargo Tracker" ^
                        -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml ^
                        -Dsonar.host.url=http://localhost:9000 ^
                        -Dsonar.token=%SONAR_TOKEN%
                    '''
                }
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
