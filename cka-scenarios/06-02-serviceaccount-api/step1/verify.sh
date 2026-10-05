#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get sa api-access -n apps >/dev/null || fail "ServiceAccount missing"
kubectl get clusterrole api-clusterrole >/dev/null || fail "ClusterRole missing"
verbs=$(kubectl get clusterrole api-clusterrole -o jsonpath='{.rules[0].verbs[*]}')
for v in get list watch; do echo "$verbs" | grep -qw "$v" || fail "missing $v"; done
echo "$verbs" | grep -qw delete && fail "delete should not be granted"
res=$(kubectl get clusterrole api-clusterrole -o jsonpath='{.rules[0].resources[0]}')
[[ "$res" == "pods" ]] || fail "ClusterRole does not target pods"
kubectl get clusterrolebinding api-clusterrolebinding >/dev/null || fail "ClusterRoleBinding missing"
sa=$(kubectl get clusterrolebinding api-clusterrolebinding -o jsonpath='{.subjects[?(@.kind=="ServiceAccount")].name}')
ns=$(kubectl get clusterrolebinding api-clusterrolebinding -o jsonpath='{.subjects[?(@.kind=="ServiceAccount")].namespace}')
[[ "$sa" == "api-access" && "$ns" == "apps" ]] || fail "binding subject is $ns/$sa"
echo OK
