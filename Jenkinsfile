pipeline {
  environment {
    imagename = 'devops-challenge/retov1'
    registryCredential = 'xxxxxxxx'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git([url: 'https://github.com/arcmop/reto-cesar-ortiz.git', branch: 'master', credentialsId: 'xxxxxxxxxxxx'])
      }
    }
    stage('Construir imagen') {
      steps {
        script {
          dockerImage = docker.build imagename
        }
      }
    }
    stage('Deployar Imagen') {
      steps {
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("$BUILD_NUMBER")
            dockerImage.push('latest')
          }
        }
      }
    }
    stage('Quitar temporales') {
      steps {
        sh "docker rmi $imagename:$BUILD_NUMBER"
        sh "docker rmi $imagename:latest"
      }
    }
  }
}
