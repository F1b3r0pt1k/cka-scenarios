#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

cpu=$(kubectl get deploy nginx -o jsonpath='{.spec.template.spec.containers[0].resources.requests.cpu}')
mem=$(kubectl get deploy nginx -o jsonpath='{.spec.template.spec.containers[0].resources.requests.memory}')
lim=$(kubectl get deploy nginx -o jsonpath='{.spec.template.spec.containers[0].resources.limits.memory}')
[[ "$cpu" == "100m" ]] || fail "cpu request is $cpu"
[[ "$mem" == "128Mi" ]] || fail "memory request is $mem"
[[ "$lim" == "128Mi" ]] || fail "memory limit is $lim"
kubectl get hpa nginx-hpa >/dev/null || fail "HPA missing"
min=$(kubectl get hpa nginx-hpa -o jsonpath='{.spec.minReplicas}')
max=$(kubectl get hpa nginx-hpa -o jsonpath='{.spec.maxReplicas}')
[[ "$min" == "3" && "$max" == "8" ]] || fail "min/max is $min/$max"
target=$(kubectl get hpa nginx-hpa -o jsonpath='{.spec.scaleTargetRef.name}')
[[ "$target" == "nginx" ]] || fail "HPA target is $target"
metrics=$(kubectl get hpa nginx-hpa -o jsonpath='{range .spec.metrics[*]}{.resource.name}={.resource.target.averageUtilization}{"\n"}{end}')
echo "$metrics" | grep -qx 'cpu=75' || fail "CPU metric missing: $metrics"
echo "$metrics" | grep -qx 'memory=60' || fail "memory metric missing: $metrics"
echo OK
