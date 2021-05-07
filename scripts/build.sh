#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)

DATE="$(date "+%Y%m%d%H%M")"
REPOSITORY_NAME="kubernetes"
IMAGE_NAME="kubernetes-exec-with-golang"
DOCKERFILE_DIR=${SCRIPT_DIR}/../build
DOCKERFILE_NAME="Dockerfile"

DOCKER_BUILDKIT=1 docker build --secret id=ssh,src=$HOME/.ssh/id_rsa -f ${DOCKERFILE_DIR}/${DOCKERFILE_NAME} -t ${REPOSITORY_NAME}/${IMAGE_NAME}:"${DATE}" .

docker build -t ${IMAGE_NAME}:"${DATE}" . -f ${DOCKERFILE_DIR}/${DOCKERFILE_NAME}
