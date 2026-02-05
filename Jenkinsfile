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
            environment {
                SONAR_TOKEN = credentials(squ_576db34989544efc594907db996af509861c0ea5) 
            }
            steps {
                bat '''
                    mvnw sonar:sonar ^
                    -Dsonar.projectKey=cargo-tracker ^
                    -Dsonar.projectName="Cargo Tracker" ^
                    -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml ^
                    -Dsonar.host.url=http://localhost:9000 ^
                    -Dsonar.login=%SONAR_TOKEN%
                '''
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
