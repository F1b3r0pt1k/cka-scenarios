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
mkdir -p /root/certs
openssl genrsa -out /root/certs/devuser.key 2048
openssl req -new -key /root/certs/devuser.key -out /root/certs/devuser.csr -subj "/CN=devuser/O=developers"
openssl x509 -req -in /root/certs/devuser.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out /root/certs/devuser.crt -days 365
cluster=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}')
kubectl config set-credentials devuser --client-certificate=/root/certs/devuser.crt --client-key=/root/certs/devuser.key
kubectl config set-context devuser-context --cluster="$cluster" --user=devuser
kubectl create namespace development --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace production --dry-run=client -o yaml | kubectl apply -f -
touch /tmp/setup-done
