#!/bin/bash

#
# Startup script for development
#

docker-compose rm || exit $?
docker-compose build || exit $?
sudo docker-compose up || exit $?
