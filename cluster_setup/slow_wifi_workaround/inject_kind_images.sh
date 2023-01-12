#!/usr/bin/env bash
curl -LO https://raw.githubusercontent.com/cilium/cilium/1.12.5/Documentation/gettingstarted/kind-config.yaml
kind create cluster --config=kind-config.yaml

kind load docker-image quay.io/cilium/cilium:v1.12.5
kind load docker-image quay.io/cilium/operator-generic:v1.12.5