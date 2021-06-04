#!/bin/bash
# windows_docker_location=/mnt/c/'Program Files'/Docker/Docker/resources/bin
docker=docker

remove_stopped_containers(){
	echo "Starting removal of exited containers."
	# $docker rm $($docker ps -a -q)
	"$docker" rm $("$docker" ps -q -f status=exited) 2> /dev/null
}

build_dockerfile(){
	name="$1"
	location="$2"
	"$docker" build -t $name $location --build-arg secret_jenkins=$JENKINS_SECRET --build-arg remote_machine_secret=$REMOTE_MACHINE_SECRET --build-arg remote_machine_user_secret=$REMOTE_MACHINE_USER_SECRET --build-arg tmp_remote_password_secret=$TMP_REMOTE_PASSWORD_SECRET
}

create_agent() {
	source /home/p0dxd/.secrets
	cp /home/p0dxd/.secrets .secrets
	ls -la
	./run.sh build_dockerfile jenkins-agent ..
	echo "Cleaning images."
	yes | "$docker" image prune
	old_container="$(docker ps -aq --filter 'name=jenkins-agent')"
	if [ ! -z $old_container ]; then
		"$docker" stop $old_container
		"$docker" rm  $old_container
	fi
	echo "Clearing out exited containers."
	"$docker" rm $("$docker" ps -a -f status=exited -q)
	"$docker" run -d -it  -v /mnt/agent/jenkins/agent:/home/jenkins/agent -v /var/run/docker.sock:/var/run/docker.sock --name jenkins-agent jenkins-agent 
	rm .secrets
}
"$@"
