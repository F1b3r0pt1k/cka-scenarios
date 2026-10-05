#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

[[ -f /root/hello-deployment.yaml ]] || fail "manifest file missing"
grep -q 'replicas: 8' /root/hello-deployment.yaml || fail "file does not set replicas to 8"
kubectl rollout status deploy/hello --timeout=150s || fail "deployment not ready"
ready=$(kubectl get deploy hello -o jsonpath='{.status.readyReplicas}')
[[ "$ready" == "8" ]] || fail "ready replicas is $ready"
img=$(kubectl get deploy hello -o jsonpath='{.spec.template.spec.containers[0].image}')
[[ "$img" == "nginx:1.27-alpine" ]] || fail "image is $img"
echo OK
