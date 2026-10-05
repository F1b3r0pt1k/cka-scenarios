#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl rollout status deploy/prod-web -n production --timeout=150s || fail "prod-web not ready"
kubectl rollout status deploy/staging-web -n staging --timeout=150s || fail "staging-web not ready"
from=$(kubectl get gateway edge -n production -o jsonpath='{.spec.listeners[0].allowedRoutes.namespaces.from}')
[[ "$from" == "All" ]] || fail "allowedRoutes is $from"
ptype=$(kubectl get httproute prod-route -n production -o jsonpath='{.spec.rules[0].matches[0].path.type}')
pval=$(kubectl get httproute prod-route -n production -o jsonpath='{.spec.rules[0].matches[0].path.value}')
pback=$(kubectl get httproute prod-route -n production -o jsonpath='{.spec.rules[0].backendRefs[0].name}')
phdr=$(kubectl get httproute prod-route -n production -o jsonpath='{.spec.rules[0].filters[?(@.type=="RequestHeaderModifier")].requestHeaderModifier.set[0].value}')
[[ "$ptype" == "Exact" && "$pval" == "/app" && "$pback" == "prod-web" ]] || fail "prod route is $ptype $pval -> $pback"
[[ "$phdr" == "production" ]] || fail "prod header is $phdr"
stype=$(kubectl get httproute staging-route -n staging -o jsonpath='{.spec.rules[0].matches[0].path.type}')
sval=$(kubectl get httproute staging-route -n staging -o jsonpath='{.spec.rules[0].matches[0].path.value}')
sback=$(kubectl get httproute staging-route -n staging -o jsonpath='{.spec.rules[0].backendRefs[0].name}')
shdr=$(kubectl get httproute staging-route -n staging -o jsonpath='{.spec.rules[0].filters[?(@.type=="RequestHeaderModifier")].requestHeaderModifier.set[0].value}')
sparentns=$(kubectl get httproute staging-route -n staging -o jsonpath='{.spec.parentRefs[0].namespace}')
[[ "$stype" == "PathPrefix" && "$sval" == "/staging" && "$sback" == "staging-web" ]] || fail "staging route is $stype $sval -> $sback"
[[ "$shdr" == "staging" ]] || fail "staging header is $shdr"
[[ "$sparentns" == "production" ]] || fail "staging parent namespace is $sparentns"
grant=$(kubectl get referencegrant -n production -o jsonpath='{.items[0].spec.from[0].namespace}')
[[ "$grant" == "staging" ]] || fail "ReferenceGrant does not allow staging (got $grant)"
echo OK
