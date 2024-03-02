pipeline {
    agent {
    label 'docker' 
  }

     environment {
        PATH = "$PATH:/usr/local/share/dotnet"
        DOCKER_IMAGE = 'mcr.microsoft.com/dotnet/runtime:7.0'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    sh 'dotnet build /Users/swiperrr/Desktop/Sample/Sample.csproj'
                    sh 'dotnet publish /Users/swiperrr/Desktop/Sample/Sample.csproj --configuration Release --output ./publish'                    

                    archiveArtifacts artifacts: 'publish/'
                }
            }
        }

        stage('Publish Artifacts') {
                    steps {
                        script {                    
                            archiveArtifacts artifacts: 'publish/'
                        }
                    }
                }

        stage('Run in Docker') {
            steps {
                script {
                    echo 'Building Docker image...'
                    docker.build DOCKER_IMAGE

                    echo 'Running application in Docker container...'
                    docker.image(DOCKER_IMAGE).run('-p 9090:90')

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