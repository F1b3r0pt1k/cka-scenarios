#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

unsched=$(kubectl get node node01 -o jsonpath='{.spec.unschedulable}')
[[ "$unsched" == "true" ]] || fail "node01 is not cordoned"
left=$(kubectl get pods -A --field-selector spec.nodeName=node01 -o jsonpath='{range .items[*]}{.metadata.ownerReferences[0].kind}{"\n"}{end}' | sed '/^$/d' | grep -v '^DaemonSet$' || true)
if [[ -n "${left// }" ]]; then
  fail "node01 still has non-DaemonSet Pods"
fi
echo OK
