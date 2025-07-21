FROM ubuntu:latest

ARG GH_OST_VERSION=1.1.7
ARG GH_OST_DOWNLOAD_URL=https://github.com/github/gh-ost/releases/download/v${GH_OST_VERSION}/gh-ost_${GH_OST_VERSION}_amd64.deb

RUN apt-get update && \
    apt-get install -y curl ca-certificates file --no-install-recommends netcat-openbsd socat && \
    rm -rf /var/lib/apt/lists/*

RUN echo "Downloading from: ${GH_OST_DOWNLOAD_URL}" && \
    curl -SL -o /tmp/gh-ost.deb ${GH_OST_DOWNLOAD_URL} && \
    echo "--- Downloaded file info: ---" && \
    ls -l /tmp/gh-ost.deb && \
    echo "--- File type: ---" && \
    file /tmp/gh-ost.deb && \
    echo "--- Attempting to install .deb package: ---" && \
    dpkg -i /tmp/gh-ost.deb && \
    rm /tmp/gh-ost.deb

WORKDIR /app

# Copy my.cnf to /root/.my.cnf
COPY my.cnf /root/.my.cnf