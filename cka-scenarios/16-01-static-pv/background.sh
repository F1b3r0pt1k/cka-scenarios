#!/bin/bash
set -euo pipefail
for _ in $(seq 1 60); do
  kubectl get nodes >/dev/null 2>&1 && break
  sleep 2
done
kubectl wait --for=condition=Ready nodes --all --timeout=240s
mkdir -p /var/logs
chmod 777 /var/logs
ssh -o StrictHostKeyChecking=no -o BatchMode=yes node01 'mkdir -p /var/logs && chmod 777 /var/logs'
touch /tmp/setup-done
