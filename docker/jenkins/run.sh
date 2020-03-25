source ~/.bashrc
docker run -d  -v /mnt/jenkins/var/jenkins_home:/var/jenkins_home -p 8081:8081 jenkins-website --httpPort=-1 --httpsPort=8081 --httpsKeyStore=/var/jenkins_home/website.jks --httpsKeyStorePassword=$KEYSTORE_PASSWORD
