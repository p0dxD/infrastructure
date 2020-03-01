#!/bin/bash
protocol="http"
# url=$(ifconfig | awk '/inet /{print $2}' | head -n 1)
url="192.168.39.193"
port="8080"
echo "Making directory"
mkdir -p /home/jenkins/agent
echo "Geting agent."
curl $protocol://$url:$port/jnlpJars/agent.jar --output /home/agent.jar
echo "Connecting agent"
java -jar /home/agent.jar -jnlpUrl $protocol://$url:$port/computer/builder.ci.jenkins/slave-agent.jnlp -secret $JENKINS_SECRET -workDir "/home/jenkins/agent"