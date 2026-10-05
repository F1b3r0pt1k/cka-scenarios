#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get configmap app-config >/dev/null || fail "ConfigMap missing"
kubectl wait --for=condition=Ready pod/backend --timeout=120s || fail "backend is not Ready"
kubectl exec backend -- cat /etc/config/application.yaml | grep -q 'log_level: info' || fail "mounted file is missing log_level"
mount=$(kubectl get pod backend -o jsonpath='{.spec.containers[0].volumeMounts[?(@.mountPath=="/etc/config")].name}')
[[ -n "$mount" ]] || fail "no volume mounted at /etc/config"
echo OK
