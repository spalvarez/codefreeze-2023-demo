#!/usr/bin/env bash

kubectl create -f https://raw.githubusercontent.com/cilium/cilium/1.12.5/examples/minikube/http-sw-app.yaml
sleep 3
kubectl get pods,svc

