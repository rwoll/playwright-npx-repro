FROM ubuntu:focal
RUN apt-get update && \
    # Install node16
    apt-get install -y curl wget && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    # Feature-parity with node.js base images.
    apt-get install -y --no-install-recommends git openssh-client && \
    npm install -g yarn && \
    # clean apt cache
    rm -rf /var/lib/apt/lists/* && \
    # Create the pwuser
    adduser pwuser

WORKDIR /src
COPY ./package.json .
COPY ./package-lock.json .
RUN DEBIAN_FRONTEND=noninteractive npx playwright@1.19 install --with-deps
RUN npm ci
COPY example.spec.ts .
CMD npx playwright test
