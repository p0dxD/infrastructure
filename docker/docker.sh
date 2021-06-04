VERSION="$1"

if [[ $VERSION == "" ]]; then 
	echo "Needs version number"
	exit 1
fi
docker pull p0dxd/website:$VERSION
previous_container="$(docker ps -aq --filter 'name=website')"
docker stop $previous_container
docker rm $previous_container
docker run -itd -p 8080:8080 --rm --name website p0dxd/website:$VERSION
