pipeline {
    agent any

    triggers {
        githubPush()
    }

    // SUPPRIME ce bloc s'il n'y a rien à mettre dedans !
    // environment {
    // }

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
                SONAR_TOKEN = credentials('sonar-token') // <-- mets l'ID correct ici
            }
            steps {
                withSonarQubeEnv('SonarQube Local') {
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
