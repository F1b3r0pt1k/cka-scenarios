#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl rollout status deploy/nginx --timeout=150s || fail "rollback did not finish"
img=$(kubectl get deploy nginx -o jsonpath='{.spec.template.spec.containers[0].image}')
[[ "$img" == "nginx:1.27.0-alpine" ]] || fail "image is $img"
echo OK
