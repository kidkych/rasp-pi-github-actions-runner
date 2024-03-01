# rasp-pi-github-actions-runner
A self-hosted Github Actions container for the Raspberry Pi 5 with support for Docker-in-Docker through sysbox. This
allows developers to quickly spin-up a docker enabled ARMv8 environment for use with Github Actions.

This relies on the host OS having [sysbox](https://github.com/nestybox/sysbox) installed which, as described by 
[jpetazzo](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/), offers optimizations for
Docker-in-Docker set ups.

# Requirements
The following must be installed on the host OS of the raspberry pi:
- [Docker](https://docs.docker.com/engine/install/)
- [sysbox](https://github.com/nestybox/sysbox/blob/master/docs/user-guide/install-package.md#installing-sysbox)

# Usage
1) Requisition a personal access token (preferably fine-grained) from [Github](https://github.com/settings/apps)

2) Rename the `.sample-env` file to `.env` and fill it out with the owner of the target repo, the name of the target
repo, and your personal access token.

3) Run `./start-container.sh` on the host to build and start the container

4) You can now run Github Actions workflows on the device by adding `runs-on: [self-hosted, linux, ARM64]`
and describing the `container` under the relevant job in your workflow file.

# Acknowledgments 
This Dockerfile is highly based on [Digital Ocean's Github Actions container](
https://testdriven.io/blog/github-actions-docker/).
