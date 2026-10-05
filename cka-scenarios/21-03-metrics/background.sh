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
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.8.0/components.yaml
if ! kubectl get deploy metrics-server -n kube-system -o jsonpath='{.spec.template.spec.containers[0].args}' | grep -q kubelet-insecure-tls; then
  kubectl -n kube-system patch deployment metrics-server --type=json -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'
fi
kubectl rollout status deploy/metrics-server -n kube-system --timeout=240s
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Namespace
metadata:
  name: stress
---
apiVersion: v1
kind: Pod
metadata:
  name: mem-low
  namespace: stress
spec:
  containers:
  - name: stress
    image: polinux/stress:1.0.4
    command: ["stress", "--vm", "1", "--vm-bytes", "48M", "--vm-hang", "1"]
    resources:
      requests:
        memory: 64Mi
      limits:
        memory: 96Mi
---
apiVersion: v1
kind: Pod
metadata:
  name: mem-mid
  namespace: stress
spec:
  containers:
  - name: stress
    image: polinux/stress:1.0.4
    command: ["stress", "--vm", "1", "--vm-bytes", "96M", "--vm-hang", "1"]
    resources:
      requests:
        memory: 128Mi
      limits:
        memory: 192Mi
---
apiVersion: v1
kind: Pod
metadata:
  name: mem-high
  namespace: stress
spec:
  containers:
  - name: stress
    image: polinux/stress:1.0.4
    command: ["stress", "--vm", "1", "--vm-bytes", "160M", "--vm-hang", "1"]
    resources:
      requests:
        memory: 192Mi
      limits:
        memory: 256Mi

EOF
kubectl wait --for=condition=Ready pod -n stress --all --timeout=240s
touch /tmp/setup-done
