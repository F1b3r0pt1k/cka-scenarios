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
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Namespace
metadata:
  name: team-alpha
  labels:
    team: alpha
---
apiVersion: v1
kind: Namespace
metadata:
  name: team-beta
  labels:
    team: beta
---
apiVersion: v1
kind: Pod
metadata:
  name: alpha-app
  namespace: team-alpha
  labels:
    app: alpha-app
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sh", "-c", "sleep 3600"]
---
apiVersion: v1
kind: Pod
metadata:
  name: beta-app
  namespace: team-beta
  labels:
    app: beta-app
spec:
  containers:
  - name: app
    image: nginx:1.27-alpine
    ports:
    - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: beta-app
  namespace: team-beta
spec:
  selector:
    app: beta-app
  ports:
  - port: 80
    targetPort: 80
---
apiVersion: v1
kind: Pod
metadata:
  name: outsider
  namespace: default
  labels:
    app: outsider
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sh", "-c", "sleep 3600"]
EOF
kubectl wait --for=condition=Ready pod/alpha-app -n team-alpha --timeout=180s
kubectl wait --for=condition=Ready pod/beta-app -n team-beta --timeout=180s
kubectl wait --for=condition=Ready pod/outsider --timeout=180s
touch /tmp/setup-done
