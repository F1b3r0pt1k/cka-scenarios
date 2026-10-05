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

manifest=/etc/kubernetes/manifests/kube-scheduler.yaml
cp "$manifest" "${manifest}.backup"
sed -i -E 's|(image:.*kube-scheduler:).*|\1v1.99.0|' "$manifest"
for _ in $(seq 1 40); do
  image=$(kubectl get pod -n kube-system -l component=kube-scheduler -o jsonpath='{.items[0].spec.containers[0].image}' 2>/dev/null || true)
  echo "$image" | grep -q 'v1.99.0' && break
  sleep 3
done
touch /tmp/setup-done
