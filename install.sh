#!/usr/bin/env bash
curl -LO https://raw.githubusercontent.com/cilium/cilium/1.12.5/Documentation/gettingstarted/kind-config.yaml
kind create cluster --config=kind-config.yaml

# Install cilium cli
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/master/stable.txt)
CLI_ARCH=amd64

if [ "$(uname)" = "Darwin" ]; then
    if [ "$(uname -m)" = "arm64" ]; then CLI_ARCH=arm64; fi
    curl -L --fail --remote-name-all "https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-darwin-${CLI_ARCH}.tar.gz{,.sha256sum}"
    shasum -a 256 -c cilium-darwin-${CLI_ARCH}.tar.gz.sha256sum
    sudo tar xzvfC cilium-darwin-${CLI_ARCH}.tar.gz /usr/local/bin
    rm cilium-darwin-${CLI_ARCH}.tar.gz{,.sha256sum}     
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
    curl -L --fail --remote-name-all "https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}"
    sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
    sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
    rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
fi

# Install cilium
cilium install

#Test install
cilium status --wait

# Validate networking (Takes quite a while)
#cilium connectivity test

# Enable Hubble
cilium hubble enable --ui

# Install Hubble
export HUBBLE_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/hubble/master/stable.txt)
HUBBLE_ARCH=amd64

if [ "$(uname)" = "Darwin" ]; then
    if [ "$(uname -m)" = "arm64" ]; then HUBBLE_ARCH=arm64; fi
    curl -L --fail --remote-name-all "https://github.com/cilium/hubble/releases/download/${HUBBLE_VERSION}/hubble-darwin-${HUBBLE_ARCH}.tar.gz{,.sha256sum}"
    shasum -a 256 -c hubble-darwin-${HUBBLE_ARCH}.tar.gz.sha256sum
    sudo tar xzvfC hubble-darwin-${HUBBLE_ARCH}.tar.gz /usr/local/bin
    rm hubble-darwin-${HUBBLE_ARCH}.tar.gz{,.sha256sum}
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    if [ "$(uname -m)" = "aarch64" ]; then HUBBLE_ARCH=arm64; fi
    curl -L --fail --remote-name-all "https://github.com/cilium/hubble/releases/download/${HUBBLE_VERSION}/hubble-linux-${HUBBLE_ARCH}.tar.gz{,.sha256sum}"
    sha256sum --check hubble-linux-${HUBBLE_ARCH}.tar.gz.sha256sum
    sudo tar xzvfC hubble-linux-${HUBBLE_ARCH}.tar.gz /usr/local/bin
    rm hubble-linux-${HUBBLE_ARCH}.tar.gz{,.sha256sum}
fi

# Validate Hubble access
hubble status

