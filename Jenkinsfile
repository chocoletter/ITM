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

        stage('Run App') {
            steps {
                dir('frontend\\EasyDevOps\\publish') {
                    bat '''
                    if exist app.log del app.log
                    set ASPNETCORE_URLS=http://localhost:5000
                    start "" cmd /c "dotnet WebApplication3.dll > app.log 2>&1"
                    powershell -Command "Start-Sleep -Seconds 5"
                    '''
                }
            }
        }

        stage('Smoke Test') {
            steps {
                bat '''
                powershell -Command "try { (Invoke-WebRequest -UseBasicParsing ''http://localhost:5000'' -TimeoutSec 10).StatusCode } catch { Write-Error $_; exit 1 }"
                '''
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
