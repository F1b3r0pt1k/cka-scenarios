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

cat > /root/fix-me-deployment.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      run: server
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.27-alpine
        ports:
        - containerPort: 80
EOF
touch /tmp/setup-done
