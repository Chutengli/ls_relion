#!/bin/bash

set -e

docker_cmd="docker"
sudo="sudo"
container="cryohub-RELION-docker"

# the image to use
relion_container_img="relion"

function build_image() {
  $sudo $docker_cmd build --no-cache -t $relion_container_img .
}

function start_container() {
  $sudo $docker_cmd run -dit --name $container $relion_container_img
}

# check for running container
$sudo $docker_cmd ps | grep -q $container && $sudo $docker_cmd stop $container
$sudo $docker_cmd -a ps | grep -q $container && $sudo $docker_cmd rm $container

echo "building the RELION image"
build_image || echo "fail to build RELION image" && exit 1
echo "RELION image is built successfully"
echo "starting the cryohub-relion container"
start_container || echo "fail to start cryohub-RELION container" && exit 1
echo "the cryohub-RELION container is built successfully"

exit 0
