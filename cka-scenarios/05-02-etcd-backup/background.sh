#!/bin/bash
set -euo pipefail

if ! grep -q "CKA exam shortcuts" /root/.bashrc 2>/dev/null; then
  cat >> /root/.bashrc <<'EOF'

# CKA exam shortcuts
alias k=kubectl
export do="--dry-run=client -o yaml"
export now="--force --grace-period=0"
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion bash)
  complete -o default -F __start_kubectl k
fi
EOF
fi
cat > /root/.vimrc <<'EOF'
set tabstop=2
set shiftwidth=2
set expandtab
EOF
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
