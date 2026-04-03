pipeline {
    agent any

    triggers {
        githubPush()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Verify .NET') {
            steps {
                bat 'dotnet --version'
            }
        }

        stage('Restore') {
            steps {
                dir('frontend\\EasyDevOps') {
                    bat 'dotnet restore WebApplication3.csproj'
                }
            }
        }

        stage('Build') {
            steps {
                dir('frontend\\EasyDevOps') {
                    bat 'dotnet build WebApplication3.csproj --configuration Release --no-restore'
                }
            }
        }

        stage('Publish') {
            steps {
                dir('frontend\\EasyDevOps') {
                    bat 'dotnet publish WebApplication3.csproj --configuration Release --output publish --no-build'
                }
            }
        }
    }

    post {
        success {
            echo 'Frontend build succesvol afgerond.'
        }
        failure {
            echo 'Frontend build mislukt.'
        }
    }
}
