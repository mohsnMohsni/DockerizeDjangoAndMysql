# list of containers
docker ps -a
docker ps -q
docker ps

# run compose as build image
docker-compose up --build

# run command on compose service
docker-compose run <container_name> <command>

# force running container
docker exec -it <container_id> tail -f /dev/null

# run an image
docker run <image>

# build image
docker build .

# remove container
docker rm -f <container_id>

# remove all containers
docker rm -f $(docker ps -aq)

# remove image
docker image rm -f <image_id>

# remove all images
docker image rm -f $(docker images -q)

# list of images
docker iamges 

# output of image
docker save -o image_name.tar <image>

# import image
docker import <path>

# remove <none> images
docker image rm -f $(docker images -q --filter "dangling=true")

# exec command on running container
docker exec -it <container_id>

# down compose services
docker-compose down

# ports, volume, etc.
host:container

# show logs
docker logs <container>
