#!/bin/bash
source /home/p0dxd/.bashrc
source /home/p0dxd/.secrets
docker pull jenkins/jenkins:latest
cp /home/p0dxd/.certs/website.jks .
docker build -t jenkins-website .
rm website.jks
previous_container="$(docker ps -aq --filter 'name=jenkins-website')"
docker stop $previous_container
docker rm $previous_container
docker run -dit  -v /mnt/jenkins/var/jenkins_home:/var/jenkins_home -p 50000:50000 -p 8081:8081 --name jenkins-website -e JAVA_OPTS="-Xmx1000m" jenkins-website --httpPort=-1 --httpsPort=8081 --httpsKeyStore=$KEYSTORE_LOCATION_SECRET --httpsKeyStorePassword=$KEYSTORE_PASSWORD_SECRET
