#!/bin/bash
set -euo pipefail
for _ in $(seq 1 60); do
  kubectl get nodes >/dev/null 2>&1 && break
  sleep 2
done
kubectl wait --for=condition=Ready nodes --all --timeout=240s
for _ in $(seq 1 30); do
  etcd=$(kubectl get pods -n kube-system --no-headers | awk '/^etcd-/{print $1; exit}')
  [[ -n "${etcd:-}" ]] && break
  sleep 2
done
kubectl wait --for=condition=Ready "pod/$etcd" -n kube-system --timeout=180s
kubectl cp "kube-system/${etcd}:/usr/local/bin/etcdctl" /usr/local/bin/etcdctl
if kubectl exec -n kube-system "$etcd" -- test -x /usr/local/bin/etcdutl; then
  kubectl cp "kube-system/${etcd}:/usr/local/bin/etcdutl" /usr/local/bin/etcdutl
fi
chmod +x /usr/local/bin/etcdctl /usr/local/bin/etcdutl 2>/dev/null || true
touch /tmp/setup-done
