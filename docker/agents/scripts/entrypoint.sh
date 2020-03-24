#!/bin/bash
protocol="https"
# url=$(ifconfig | awk '/inet /{print $2}' | head -n 1)
url="joserod.space"
port="8081"
echo "Geting agent."
curl $protocol://$url:$port/jnlpJars/agent.jar --output /home/agent.jar
echo "Connecting agent"
java -jar /home/agent.jar -jnlpUrl $protocol://$url:$port/computer/builder.ci.jenkins/slave-agent.jnlp -secret $JENKINS_SECRET -workDir "/home/jenkins/agent"
