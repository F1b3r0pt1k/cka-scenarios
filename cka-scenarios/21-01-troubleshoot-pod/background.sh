#!/bin/bash
set -euo pipefail
for _ in $(seq 1 60); do
  kubectl get nodes >/dev/null 2>&1 && break
  sleep 2
done
kubectl wait --for=condition=Ready nodes --all --timeout=240s

cat > /root/recorder.yaml <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: recorder
spec:
  containers:
  - name: recorder
    image: busybox:1.36
    command: ["sh", "-c", "if echo started > /var/log/app/marker.txt; then echo WRITE_OK; else echo WRITE_FAILED; fi; sleep 3600"]
EOF
kubectl apply -f /root/recorder.yaml
touch /tmp/setup-done
