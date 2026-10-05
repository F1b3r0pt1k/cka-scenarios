#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

for n in controlplane node01; do
  kubectl wait --for=condition=Ready "node/$n" --timeout=90s || fail "$n is not Ready"
  unsched=$(kubectl get node "$n" -o jsonpath='{.spec.unschedulable}')
  [[ "$unsched" == "true" ]] && fail "$n is still cordoned"
done
echo OK
