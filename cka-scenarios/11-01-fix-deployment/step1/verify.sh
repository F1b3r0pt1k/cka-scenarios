#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get deploy nginx >/dev/null || fail "Deployment nginx missing"
kubectl rollout status deploy/nginx --timeout=120s || fail "replicas are not ready"
ready=$(kubectl get deploy nginx -o jsonpath='{.status.readyReplicas}')
[[ "$ready" == "3" ]] || fail "ready replicas is $ready"
sel=$(kubectl get deploy nginx -o jsonpath='{.spec.selector.matchLabels}')
labels=$(kubectl get deploy nginx -o jsonpath='{.spec.template.metadata.labels}')
[[ "$sel" == "$labels" ]] || fail "selector $sel does not match template labels $labels"
echo OK
