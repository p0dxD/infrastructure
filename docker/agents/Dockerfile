FROM ubuntu:latest
RUN apt-get update \
    && apt-get install -y openjdk-8-jdk && apt-get install -y curl \
    && apt-get install -y git \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs \
    && apt install -y wget \
    && wget https://services.gradle.org/distributions/gradle-5.0-bin.zip -P /tmp \
    && apt install -y zip \
    && unzip -d /opt/gradle /tmp/gradle-*.zip \
    && apt-get install -y net-tools

# for docker
RUN apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io

# for golang
RUN add-apt-repository ppa:longsleep/golang-backports \
    && apt-get update && apt-get install -y golang-go \
    && mkdir /home/go 

#Environments
ENV GOPATH /home/go
ENV GRADLE_HOME /opt/gradle/gradle-5.0
ENV PATH $GRADLE_HOME/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64/
ENV PATH $JAVA_HOME/bin:$PATH
ARG secret_jenkins
ENV JENKINS_SECRET ${secret_jenkins}

COPY scripts/.secrets /home/.secrets
COPY scripts/entrypoint.sh /home/entrypoint.sh

CMD [ "/home/entrypoint.sh" ]
