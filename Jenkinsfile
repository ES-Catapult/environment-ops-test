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
          sh 'make delete'
          sh 'make install'
        }
      }
    }
  }
}
