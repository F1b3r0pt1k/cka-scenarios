#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl wait --for=condition=Ready pod/web --timeout=120s || fail "web is not Ready"
node=$(tr -d '[:space:]' < /root/pod-node.txt)
actual=$(kubectl get pod web -o jsonpath='{.spec.nodeName}')
[[ "$actual" == "$node" ]] || fail "web is on $actual, expected $node"
key=$(kubectl get pod web -o jsonpath='{.spec.tolerations[?(@.key=="exclusive")].key}')
val=$(kubectl get pod web -o jsonpath='{.spec.tolerations[?(@.key=="exclusive")].value}')
eff=$(kubectl get pod web -o jsonpath='{.spec.tolerations[?(@.key=="exclusive")].effect}')
[[ "$key" == "exclusive" && "$val" == "yes" && "$eff" == "NoExecute" ]] || fail "toleration is $key=$val:$eff"
taint=$(kubectl get node "$node" -o jsonpath='{range .spec.taints[*]}{.key}={.value}:{.effect}{"\n"}{end}')
echo "$taint" | grep -q 'exclusive=yes:NoExecute' && fail "taint is still present"
echo OK
