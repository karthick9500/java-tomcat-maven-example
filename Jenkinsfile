@Library('shared-library@master') _
import groovy.json.JsonSlurperClassic

pipeline {

agent any
  
environment {
    DOCKER_COMMON_CREDS = credentials('a05e481d-4987-4a51-8569-41fc1a47e11e')
}
  
  
  
stages {

  stage("Init"){
      steps {
              sh 'echo "Initialize"'
              sh 'docker login -u $DOCKER_COMMON_CREDS_USR -p $DOCKER_COMMON_CREDS_PSW'
              script {
                echo "Loading JSON configuration from : ${env.WORKSPACE}/pipeline.json"
                inputFile = readFile("${env.WORKSPACE}/pipeline.json")
                parsedJson = new JsonSlurperClassic().parseText(inputFile)
                echo "Done Loading JSON configuration"
                
            }
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
                            sh 'echo "done"'
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
                            sh 'echo "done"'
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
                        ValidateApp(parsedJson,'app1')
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
                        ValidateApp(parsedJson,'app2')
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
                env.APP_SHUTDOWN = input message: 'User input required',
                ok: 'Shutdown!',
                parameters: [choice(name: 'App to shutdown', choices: "APP1\nAPP2\nBOTH\nNONE", description: 'Which app you want to shutdown?')]
            }
        }
    }
  
  
  stage('Process Shutdown'){
        steps{
          PerformShutdown(${env.$APP_SHUTDOWN})
        }
    }
    
    
    
    
    
}


}
