FROM ubuntu:latest
RUN apt-get update \
    && apt-get install -y openjdk-8-jdk && apt-get install -y curl \
    && apt-get install -y git

# for docker
RUN apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io

#Remote ssh
RUN apt-get install -y sshpass
ARG remote_machine_secret
ARG remote_machine_user_secret
ARG tmp_remote_password_secret
RUN cat /dev/zero | ssh-keygen -q -N "" 
RUN ls -la /home/p0dxd/.ssh
RUN echo  ${remote_machine_user_secret}
RUN sshpass -p ${tmp_remote_password_secret} ssh-copy-id -o StrictHostKeyChecking=no -i  /root/.ssh/id_rsa.pub ${remote_machine_user_secret}@${remote_machine_secret}

RUN mkdir -p /home/jenkins/agent
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
