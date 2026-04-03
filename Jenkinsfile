pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        APP_URL = 'http://localhost:5000'
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

        stage('Run App') {
            steps {
                dir('frontend\\EasyDevOps\\publish') {
                    bat """
                    set ASPNETCORE_URLS=${APP_URL}
                    start /B dotnet WebApplication3.dll
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Frontend build en start succesvol afgerond.'
        }
        failure {
            echo 'Frontend build of start mislukt.'
        }
    }
}
