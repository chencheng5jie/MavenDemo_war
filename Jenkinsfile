node {
   def mvnHome
   stage('Checkout SCM') {
      //git 'https://github.com/MahadevDevops/MavenDemo_war.git'
      checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/MahadevDevops/MavenDemo_war.git']]])

      mvnHome = tool 'M3'
   }
   stage('Build') {
      
	  echo "Im in Build stage" 
         sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
     
   }
   stage('Results') {
      //junit '**/target/surefire-reports/TEST-*.xml'
      archiveArtifacts 'target/*.war'
   }
   
   
   stage('SonarQube Analysis') {
       // def mvnHome =  tool name: 'M3', type: 'maven'
        withSonarQubeEnv('mySonar') { 
          sh "${mvnHome}/bin/mvn sonar:sonar"
        }
    
    }
   
  /*
   stage("Quality Gate"){
          timeout(time: 1, unit: 'MINUTES') {
              def qg = waitForQualityGate()
              if (qg.status != 'OK') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
              }
          }
      }
 
	 */ 
   
   stage('Publish to Sonar') {
        echo "Publishing"
        nexusPublisher nexusInstanceId: 'MyNexus', nexusRepositoryId: 'maven-releases', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: '/var/lib/jenkins/workspace/FinalPipeline/target/my-app.war']], mavenCoordinate: [artifactId: 'my-app', groupId: 'com.mycompany.app', packaging: 'war', version: '10']]]
        
        
    } 
    
    
    stage('Deploy to Tomcat'){
    
        sh 'scp target/*.war root@10.142.0.11:/var/lib/tomcat8/webapps/'
        //sh 'sudo service tomcat8 restart'
        
    }
} 
