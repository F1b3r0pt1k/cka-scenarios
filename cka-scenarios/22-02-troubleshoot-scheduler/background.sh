#!/bin/bash
set -euo pipefail
for _ in $(seq 1 60); do
  kubectl get nodes >/dev/null 2>&1 && break
  sleep 2
done
kubectl wait --for=condition=Ready nodes --all --timeout=240s

manifest=/etc/kubernetes/manifests/kube-scheduler.yaml
cp "$manifest" "${manifest}.backup"
sed -i -E 's|(image:.*kube-scheduler:).*|\1v1.99.0|' "$manifest"
for _ in $(seq 1 40); do
  image=$(kubectl get pod -n kube-system -l component=kube-scheduler -o jsonpath='{.items[0].spec.containers[0].image}' 2>/dev/null || true)
  echo "$image" | grep -q 'v1.99.0' && break
  sleep 3
done
touch /tmp/setup-done
