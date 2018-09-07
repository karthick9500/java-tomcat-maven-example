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
    
  stage('run-parallel-branches') {
    steps {
      parallel(
        a: {
          echo "docker build  -t karthick9500/sape-poc-1:1 ."
        },
        b: {
          echo "docker build  -t karthick9500/sape-poc-2:1 ."
        }
      )
    }
  }
  
    
    
    
    
    
}


}
