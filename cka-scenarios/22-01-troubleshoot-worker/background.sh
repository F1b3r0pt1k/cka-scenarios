#!/bin/bash
set -euo pipefail
for _ in $(seq 1 60); do
  kubectl get nodes >/dev/null 2>&1 && break
  sleep 2
done
kubectl wait --for=condition=Ready nodes --all --timeout=240s

ssh -o StrictHostKeyChecking=no -o BatchMode=yes node01 'systemctl stop kubelet' \
  || ssh -o StrictHostKeyChecking=no -o BatchMode=yes root@172.30.2.2 'systemctl stop kubelet'
kubectl cordon node01
touch /tmp/setup-done
