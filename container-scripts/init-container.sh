#!/bin/bash
dockerd > /var/log/dockerd.log 2>&1 &
su github -c "container-scripts/start-actions-runner.sh"
