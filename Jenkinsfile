pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    bat 'dotnet build Sample.csproj'
                    bat 'dotnet publish Sample.csproj --configuration Release --output ./publish'

                    def output = bat(script: "dir /b /s publish\*", returnStdout: true).trim()
                    echo "Build output: ${output}"

                    archiveArtifacts artifacts: 'publish/'
                }
            }
        }
    }

    post {
        success {
            echo 'Build successful!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}