#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

ready=0
for _ in $(seq 1 30); do
  if kubectl get endpoints -n monitoring -o jsonpath='{range .items[*]}{.subsets[0].addresses[0].ip}{"\n"}{end}' | grep -q .; then
    ready=1
    break
  fi
  sleep 2
done
[[ "$ready" == "1" ]] || fail "no Service in monitoring has endpoints"
echo OK
