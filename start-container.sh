#!/bin/bash

docker build . -t rasp-pi-github-actions-runner
docker run \
    --runtime=sysbox-runc \
    --env-file ./.env \
    --name rasp-pi-github-actions-runner \
    --detach \
    --restart always \
    rasp-pi-github-actions-runner
