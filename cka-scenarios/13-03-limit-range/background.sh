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

cat > /root/limitrange.yaml <<'EOF'
apiVersion: v1
kind: Namespace
metadata:
  name: limited
---
apiVersion: v1
kind: LimitRange
metadata:
  name: cpu-limit-range
  namespace: limited
spec:
  limits:
  - type: Container
    min:
      cpu: 200m
    max:
      cpu: 500m
    default:
      cpu: 500m
    defaultRequest:
      cpu: 200m
EOF
touch /tmp/setup-done
