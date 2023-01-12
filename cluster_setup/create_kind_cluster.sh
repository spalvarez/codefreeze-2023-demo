#!/usr/bin/env bash
curl -LO https://raw.githubusercontent.com/cilium/cilium/1.12.5/Documentation/gettingstarted/kind-config.yaml
kind create cluster --config=kind-config.yaml