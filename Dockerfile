FROM arm64v8/ubuntu:23.10

ARG RUNNER_VERSION="2.313.0"

RUN apt-get update -y && apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates curl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
        -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) \
        signed-by=/etc/apt/keyrings/docker.asc] \
        https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli \
        containerd.io docker-buildx-plugin docker-compose-plugin jq \
        build-essential libssl-dev libffi-dev python3 python3-venv python3-dev \
        python3-pip && \
    useradd -m github && usermod -aG docker github && \
    mkdir /home/github/actions-runner && cd /home/github/actions-runner && \
    curl -O -L \
        https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz && \
    tar xzf ./actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz && \
    rm actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz && \
    chown -R github /home/github && \
    /home/github/actions-runner/bin/installdependencies.sh

COPY container-scripts container-scripts

RUN chmod -R +x container-scripts

ENTRYPOINT ["container-scripts/init-container.sh"]
