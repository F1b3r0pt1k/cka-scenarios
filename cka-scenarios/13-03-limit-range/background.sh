#!/bin/bash
set -euo pipefail
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
