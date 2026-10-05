#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl wait --for=condition=Ready pod/hello --timeout=120s || fail "Pod not Ready"
c=$(kubectl get pod hello -o jsonpath='{.spec.containers[0].resources.requests.cpu}')
mr=$(kubectl get pod hello -o jsonpath='{.spec.containers[0].resources.requests.memory}')
er=$(kubectl get pod hello -o jsonpath='{.spec.containers[0].resources.requests.ephemeral-storage}')
ml=$(kubectl get pod hello -o jsonpath='{.spec.containers[0].resources.limits.memory}')
el=$(kubectl get pod hello -o jsonpath='{.spec.containers[0].resources.limits.ephemeral-storage}')
cl=$(kubectl get pod hello -o jsonpath='{.spec.containers[0].resources.limits.cpu}')
[[ "$c" == "100m" ]] || fail "cpu request $c"
[[ "$mr" == "500Mi" ]] || fail "memory request $mr"
[[ "$er" == "1Gi" ]] || fail "ephemeral request $er"
[[ "$ml" == "500Mi" ]] || fail "memory limit $ml"
[[ "$el" == "2Gi" ]] || fail "ephemeral limit $el"
[[ -z "$cl" ]] || fail "CPU limit should be unset"
mount=$(kubectl get pod hello -o jsonpath='{.spec.containers[0].volumeMounts[?(@.mountPath=="/var/log")].name}')
[[ -n "$mount" ]] || fail "emptyDir is not mounted at /var/log"
echo OK
