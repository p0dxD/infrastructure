FROM ubuntu:latest
RUN apt-get update \
    && apt-get install -y openjdk-8-jdk && apt-get install -y curl

ENV JAVA_HOME /usr/lib/jvm/java-9-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH
ARG secret_jenkins
ENV JENKINS_SECRET ${secret_jenkins}

COPY scripts/entrypoint.sh /home/entrypoint.sh

CMD [ "/home/entrypoint.sh" ]
