node{
  def dockerImageName='test:$BUILD_NUMBER'
  def dockerContainerName='simplehtml_$BUILD_NUMBER'
  withCredentials(
	([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
	string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')])) {
	  sh 'curl -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d "chat_id=${CHAT_ID}" -d text="Jenkins start deploy"'
  	}
  
  stage('SCM'){
	try {
		echo 'checkout from git'
		git url: 'https://github.com/SamanthaMeliora/HTMLtest.git', branch: 'master'
	} catch(err) {
	        throw err
      	}
  }
  
  stage('Build Docker Image'){
	try {  
		sh "docker build -t ${dockerImageName} ."
        } catch (err) {
		echo err.getMessage()
        	withCredentials(
			([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
      			string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')])) {
        			sh 'curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d "chat_id=${CHAT_ID}"  -d text="[❌] Failed to build 😱"'
        			sh 'exit 1'
			}     
	}     
  }
  
  stage('Run Container'){
	  try {
		sh "docker run -p 8083:80 -d --name ${dockerContainerName} ${dockerImageName}"
		withCredentials(
			([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
      			string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')])) {
      				sh 'curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d "chat_id=${CHAT_ID}"  -d text="[✅] Build successfully 😊"'
				sh 'exit 1'
	  		} 	  
	  } catch (err) {
		echo err.getMessage()
        	withCredentials(
			([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
      			string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')])) {
        			sh 'curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d "chat_id=${CHAT_ID}"  -d text="[❌] Failed to build 😱"'
        			sh 'exit 1'
			}     
	  }   
  }
}
