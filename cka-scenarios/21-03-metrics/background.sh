#!/bin/bash
set -euo pipefail
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
