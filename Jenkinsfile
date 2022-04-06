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
        checkout([
        $class: 'GitSCM',
        branches: [[name: '*/main']],
        doGenerateSubmoduleConfigurations: false,
        extensions: [],
        submoduleCfg: [],
        userRemoteConfigs:
        [
          [ url: 'https://github.com/arcmop/reto-cesar-ortiz.git']
        ]
      ])
      }
    }
    stage('Construir imagen') {
      steps {
        script {
          dockerImage = docker.build imagename
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
