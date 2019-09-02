#!/bin/bash
# windows_docker_location=/mnt/c/'Program Files'/Docker/Docker/resources/bin
docker="$DOCKER"/docker.exe

remove_stopped_containers(){
	echo "Starting removal of exited containers."
	# $docker rm $($docker ps -a -q)
	"$docker" rm $("$docker" ps -q -f status=exited) 2> /dev/null
}

build_dockerfile(){
	name="$1"
	location="$2"
	"$docker" build -t $name $location --build-arg secret_jenkins=$JENKINS_SECRET
}

"$@"