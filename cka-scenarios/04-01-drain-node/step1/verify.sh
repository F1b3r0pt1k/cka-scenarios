#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get pod nginx >/dev/null 2>&1 && fail "Pod nginx still exists"
if ! kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}={.spec.unschedulable}{"\n"}{end}' | grep -q '=true'; then
  fail "no node is cordoned; draining a node marks it unschedulable"
fi
echo "OK"
