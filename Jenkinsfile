node{
  def dockerImageName='test:$BUILD_NUMBER'
  def dockerContainerName='simplehtml_$BUILD_NUMBER'
  withCredentials(([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
      string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')])) {
      sh 'curl -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d "chat_id=${CHAT_ID}" -d text="Jenkins start deploy"'
  }
  
  //stage(){
    //sh"docker stop " 
  //}
  
  stage('SCM'){
    //pull from this repo bitj
//     git 'https://github.com/SamanthaMeliora/HTMLtest.git'
//     def exists = fileExists 'src'
//    if (!exists){
//        new File('src').mkdir()
//    }
//    dir ('src') {
      try {
          echo 'checkout from git'
          git url: 'https://github.com/SamanthaMeliora/HTMLtest.git', branch: 'master'
//       sh "chmod +x mvnw"
      } catch(err) {
//         step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
        throw err
      }
//     }
  }
  
  
  stage('Build Docker Image'){
//     sh "docker build -t ${dockerImageName} ."
// 	dir ('src') {
		 try {  
         sh "docker build -t ${dockerImageName} ."
       } catch (err) {
        echo err.getMessage()
        withCredentials(([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
      string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')])) {
        sh 'curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d "chat_id=${CHAT_ID}"  -d text="[❌] Failed to build 😱"'
        sh 'exit 1'
      }     
     }     
//     }
  }
  
  stage('Run Container'){
    //sh "docker stop ${dockerPreviousContainer}"
	  try {
	  sh "docker run -p 8083:80 -d --name ${dockerContainerName} ${dockerImageName}"
	  withCredentials(([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
      string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')])) {
      sh 'curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d "chat_id=${CHAT_ID}"  -d text="[✅] Build successfully 😊"'
	  }
	  } catch (err) {
        echo err.getMessage()
        withCredentials(([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
      string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')])) {
        sh 'curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d "chat_id=${CHAT_ID}"  -d text="[❌] Failed to build 😱"'
//         sh 'exit 1'
      }     
     }     
  }
}

  //sshagent(['dev-server']) {
      //sh 'ssh -o StrictHostKeyChecking=no ec2-user@172.31.15.226 ${dockerRun}'
    //}
  //} 
