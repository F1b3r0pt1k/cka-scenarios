#!/bin/bash
set -euo pipefail
for _ in $(seq 1 60); do
  kubectl get nodes >/dev/null 2>&1 && break
  sleep 2
done
kubectl wait --for=condition=Ready nodes --all --timeout=240s
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Namespace
metadata:
  name: shop
---
apiVersion: v1
kind: Pod
metadata:
  name: database
  namespace: shop
  labels:
    tier: database
spec:
  containers:
  - name: redis
    image: redis:7-alpine
    ports:
    - containerPort: 6379
---
apiVersion: v1
kind: Service
metadata:
  name: database
  namespace: shop
spec:
  selector:
    tier: database
  ports:
  - port: 6379
    targetPort: 6379
---
apiVersion: v1
kind: Pod
metadata:
  name: backend
  namespace: shop
  labels:
    tier: backend
spec:
  containers:
  - name: backend
    image: busybox:1.36
    command: ["httpd", "-f", "-p", "80"]
    ports:
    - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: backend
  namespace: shop
spec:
  selector:
    tier: backend
  ports:
  - port: 80
    targetPort: 80
---
apiVersion: v1
kind: Pod
metadata:
  name: frontend
  namespace: shop
  labels:
    tier: frontend
spec:
  containers:
  - name: frontend
    image: busybox:1.36
    command: ["sh", "-c", "sleep 3600"]
EOF
kubectl wait --for=condition=Ready pod/database -n shop --timeout=180s
kubectl wait --for=condition=Ready pod/backend -n shop --timeout=180s
kubectl wait --for=condition=Ready pod/frontend -n shop --timeout=180s
touch /tmp/setup-done
