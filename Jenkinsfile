pipeline {
  agent {
    label "jenkins-maven"
  }
  environment {
    DEPLOY_NAMESPACE = "ops-scratch"
  }
  stages {
    stage('Validate Environment') {
      steps {
        container('maven') {
          sh 'make build'
        }
      }
    }
    stage('Update Environment') {
      when {
        branch 'master'
      }
      steps {
        container('maven') {
          try {
            sh 'make install'
          }
          catch (exc) {
            sh 'make delete'
          } 
        }
      }
    }
  }
}
