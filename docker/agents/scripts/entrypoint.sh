#!/bin/bash
protocol="https"
# url=$(ifconfig | awk '/inet /{print $2}' | head -n 1)
url="joserod.space"
port="8081"
echo "Making directory"
mkdir -p /etc/jenkins/agent
echo "Geting agent."
curl $protocol://$url:$port/jnlpJars/agent.jar --output /etc/agent.jar
echo "Connecting agent"
java -jar /etc/agent.jar -jnlpUrl $protocol://$url:$port/computer/builder.ci.jenkins/slave-agent.jnlp -secret $JENKINS_SECRET -workDir "/etc/jenkins/agent"
