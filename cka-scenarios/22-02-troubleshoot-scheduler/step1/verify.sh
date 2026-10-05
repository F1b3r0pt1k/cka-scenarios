#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

image=$(kubectl get pod -n kube-system -l component=kube-scheduler -o jsonpath='{.items[0].spec.containers[0].image}')
echo "$image" | grep -q 'v1.99.0' && fail "scheduler is still using $image"
kubectl wait --for=condition=Ready pod -n kube-system -l component=kube-scheduler --timeout=120s || fail "scheduler Pod is not Ready"
kubectl rollout status deploy/test-app --timeout=150s || fail "test-app is not ready"
ready=$(kubectl get deploy test-app -o jsonpath='{.status.readyReplicas}')
[[ "$ready" == "3" ]] || fail "ready replicas is $ready"
echo OK
