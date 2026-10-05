#!/bin/bash
set -euo pipefail
for _ in $(seq 1 60); do
  kubectl get nodes >/dev/null 2>&1 && break
  sleep 2
done
kubectl wait --for=condition=Ready nodes --all --timeout=240s
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.1/deploy/static/provider/baremetal/deploy.yaml
kubectl rollout status deploy/ingress-nginx-controller -n ingress-nginx --timeout=300s
touch /tmp/setup-done
