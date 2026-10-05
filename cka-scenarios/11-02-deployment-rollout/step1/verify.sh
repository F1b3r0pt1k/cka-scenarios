#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl rollout status deploy/nginx --timeout=150s || fail "rollout did not finish"
ready=$(kubectl get deploy nginx -o jsonpath='{.status.readyReplicas}')
[[ "$ready" == "3" ]] || fail "ready replicas is $ready"
tier=$(kubectl get deploy nginx -o jsonpath='{.metadata.labels.tier}')
[[ "$tier" == "backend" ]] || fail "Deployment label tier is $tier"
app=$(kubectl get deploy nginx -o jsonpath='{.spec.template.metadata.labels.app}')
[[ "$app" == "v1" ]] || fail "Pod label app is $app"
img=$(kubectl get deploy nginx -o jsonpath='{.spec.template.spec.containers[0].image}')
[[ "$img" == "nginx:1.27.4-alpine" ]] || fail "image is $img, expected the patch image before rollback"
cause=$(kubectl get deploy nginx -o jsonpath='{.metadata.annotations.kubernetes\.io/change-cause}')
hist=$(kubectl rollout history deploy/nginx 2>/dev/null || true)
if [[ "$cause" != "Pick up patch version" ]] && ! echo "$hist" | grep -q "Pick up patch version"; then
  fail "change cause was not recorded"
fi
echo OK
