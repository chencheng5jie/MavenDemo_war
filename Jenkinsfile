node {
   def mvnHome
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
