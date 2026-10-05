#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get limitrange cpu-limit-range -n limited >/dev/null || fail "LimitRange missing"
kubectl wait --for=condition=Ready pod/pod-without-requests -n limited --timeout=120s || fail "defaulted Pod is not Ready"
req=$(kubectl get pod pod-without-requests -n limited -o jsonpath='{.spec.containers[0].resources.requests.cpu}')
lim=$(kubectl get pod pod-without-requests -n limited -o jsonpath='{.spec.containers[0].resources.limits.cpu}')
[[ "$req" == "200m" ]] || fail "default request is $req"
[[ "$lim" == "500m" ]] || fail "default limit is $lim"
kubectl get pod pod-too-much-cpu -n limited >/dev/null 2>&1 && fail "pod-too-much-cpu should have been rejected"
kubectl wait --for=condition=Ready pod/pod-within-range -n limited --timeout=120s || fail "in-range Pod is not Ready"
req=$(kubectl get pod pod-within-range -n limited -o jsonpath='{.spec.containers[0].resources.requests.cpu}')
lim=$(kubectl get pod pod-within-range -n limited -o jsonpath='{.spec.containers[0].resources.limits.cpu}')
[[ "$req" == "350m" && "$lim" == "400m" ]] || fail "in-range cpu is $req/$lim"
echo OK
