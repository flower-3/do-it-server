#!/bin/bash

DOCKER_COMPOSE_PATH=/home/ubuntu/do-it-deploy/docker/server
EXIST_RED=$(sudo docker-compose -p do-it-server-red ps | grep do-it-server-red)

if [ -z "$EXIST_RED" ]; then
    # running do-it-server-green
    echo "running do-it-server-green"
    START_CONTAINER=red
    TERMINATE_CONTAINER=green
    START_PORT=8080
    TERMINATE_PORT=8081
else
    # running do-it-server-red
    echo "running do-it-server-red"
    START_CONTAINER=green
    TERMINATE_CONTAINER=red
    START_PORT=8081
    TERMINATE_PORT=8080
fi

echo "do-it-server-${START_CONTAINER} will up"

sudo docker-compose -p do-it-server-${START_CONTAINER} -f ${DOCKER_COMPOSE_PATH}/docker-compose.${START_CONTAINER}.yml up -d --build

sleep 10

echo "change nginx server port"

sudo sed -i "s/${TERMINATE_PORT}/${START_PORT}/g" /etc/nginx/conf.d/service-url.inc

echo "nginx reload"
sudo service nginx reload

echo "do-it-server-${TERMINATE_CONTAINER} down"
sudo docker-compose -p do-it-server-${TERMINATE_CONTAINER} down
sudo docker image prune -f

echo "EXIST_RED="${EXIST_RED}
