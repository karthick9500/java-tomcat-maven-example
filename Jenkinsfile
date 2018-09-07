@Library('shared-library@master') _
pipeline {

agent any
  
environment {
    DOCKER_COMMON_CREDS = credentials('a05e481d-4987-4a51-8569-41fc1a47e11e')
}
  
  
  
stages {

  stage("Init"){
       steps
      {
        sh 'echo "Initialize"'
        sh 'docker login -u $DOCKER_COMMON_CREDS_USR -p $DOCKER_COMMON_CREDS_PSW'
      }
  }
    
  stage('Build') {
            parallel {
                stage('Build app1') {
                    agent {
                        label "build-server1"
                    }
                    steps {
                        sh 'docker build  -t karthick9500/sape-poc-1:1 .'
                    }
                    post {
                        always {
                            sh 'echo "test"'
                        }
                    }
                }
                stage('Build app 2') {
                    agent {
                        label "build-server2"
                    }
                    steps {
                        sh 'docker build  -t karthick9500/sape-poc-2:1 .'
                    }
                    post {
                        always {
                            sh 'echo "test"'
                        }
                    }
                }
            }
  }
  
  
    stage('Validate') {
            parallel {
                stage('Test App1') {
                    agent {
                        label "build-server1"
                    }
                    steps {
                        ValidateApp('http://35.154.222.77:8080/','Hello')
                    }
                    post {
                        always {
                            sh 'echo "test"'
                        }
                    }
                }
                stage('Test app 2') {
                    agent {
                        label "build-server2"
                    }
                    steps {
                        ValidateApp('http://35.154.222.77:8080/','Hello')
                    }
                    post {
                        always {
                            sh 'echo "test"'
                        }
                    }
                }
            }
  }
  
  
  stage('ShutDown') {
        steps {
            script {                
                env.SHUTDOWN = input message: 'User input required',
                ok: 'Shutdown!',
                parameters: [choice(name: 'App to shutdown', choices: "APP1\nAPP2\nBOTH\nNONE", description: 'Which app you want to shutdown?')]
            }
        }
    }
  
    
    
    
    
    
}


}
