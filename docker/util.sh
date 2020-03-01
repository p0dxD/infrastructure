#!/bin/bash
function remove_exited_containers() {
	which docker
	#docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs sudo docker rm
}


"$@"
