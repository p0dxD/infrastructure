FROM jenkins/jenkins:lts
USER root
RUN mkdir /var/log/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
USER jenkins

ENV JAVA_OPTS="-Xmx8192m"
ENV JENKINS_OPTS="--handlerCountMax=300 --logfile=/var/log/jenkins/jenkins.log"

COPY website.jks /var/jenkins_home/website.jks
RUN ls -la /var/jenkins_home
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
