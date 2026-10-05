#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get clusterrole service-view >/dev/null || fail "ClusterRole service-view missing"
verbs=$(kubectl get clusterrole service-view -o jsonpath='{.rules[0].verbs[*]}')
echo "$verbs" | grep -qw get || fail "service-view missing get"
echo "$verbs" | grep -qw list || fail "service-view missing list"
res=$(kubectl get clusterrole service-view -o jsonpath='{.rules[0].resources[0]}')
[[ "$res" == "services" ]] || fail "service-view does not target services"
label=$(kubectl get clusterrole service-view -o jsonpath='{.metadata.labels.rbac\.example\.com/aggregate}')
[[ -z "$label" ]] || fail "service-view should not carry the aggregate label"
kubectl get rolebinding devuser-service-view -n development >/dev/null || fail "RoleBinding missing"
subj=$(kubectl get rolebinding devuser-service-view -n development -o jsonpath='{.subjects[0].name}')
[[ "$subj" == "devuser" ]] || fail "RoleBinding subject is $subj"
ref=$(kubectl get rolebinding devuser-service-view -n development -o jsonpath='{.roleRef.name}')
kind=$(kubectl get rolebinding devuser-service-view -n development -o jsonpath='{.roleRef.kind}')
[[ "$ref" == "service-view" && "$kind" == "ClusterRole" ]] || fail "RoleBinding does not reference ClusterRole service-view"
kubectl get clusterrole combined >/dev/null || fail "ClusterRole combined missing"
sel=$(kubectl get clusterrole combined -o jsonpath='{.aggregationRule.clusterRoleSelectors[0].matchLabels.rbac\.example\.com/aggregate}')
[[ "$sel" == "true" ]] || fail "combined is not selecting rbac.example.com/aggregate=true"
ans=$(tr -d '[:space:]' < /root/list-services.txt)
[[ "$ans" == "yes" ]] || fail "list-services.txt should contain yes, got $ans"
live=$(kubectl auth can-i list services -n development --as=devuser)
[[ "$live" == "yes" ]] || fail "devuser cannot list services in development"
echo OK
