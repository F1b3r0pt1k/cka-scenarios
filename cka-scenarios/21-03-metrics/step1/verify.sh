#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

[[ -s /root/highest-memory.txt ]] || fail "missing /root/highest-memory.txt"
name=$(tr -d '[:space:]' < /root/highest-memory.txt)
[[ "$name" == "mem-high" ]] || fail "expected mem-high, file contains $name"
ok=0
for _ in $(seq 1 10); do
  if kubectl top pods -n stress --no-headers >/tmp/top.txt 2>/dev/null; then
    rows=$(wc -l < /tmp/top.txt)
    [[ "$rows" -ge 3 ]] && ok=1 && break
  fi
  sleep 3
done
[[ "$ok" == "1" ]] || fail "kubectl top did not return three pods"
echo OK
