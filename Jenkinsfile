node {
   def mvnHome

   notifyStarted()

   stage('Checkout SCM') {
      //git 'https://github.com/MahadevDevops/MavenDemo_war.git'
      checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/MahadevDevops/MavenDemo_war.git']]])

      mvnHome = tool 'M3'
   }
   stage('Build') {
      
         sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
     
   }
   stage('Results') {
      //junit '**/target/surefire-reports/TEST-*.xml'
      archiveArtifacts 'target/*.war'
   }
   stage('Publish') {
        echo "Publishing"
        nexusPublisher nexusInstanceId: 'MyNexus', nexusRepositoryId: 'maven-releases', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: '/var/lib/jenkins/workspace/FinalPipeline/target/my-app.war']], mavenCoordinate: [artifactId: 'my-app', groupId: 'com.mycompany.app', packaging: 'war', version: '10']]]
        
        
    } 
}
def notifyStarted() {
  
  // send to email
  emailext (
      subject: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>""",
      recipientProviders: [[$class: 'DevelopersRecipientProvider']]
    )
} 
