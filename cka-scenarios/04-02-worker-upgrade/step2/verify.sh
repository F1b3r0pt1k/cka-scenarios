#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

[[ -s /root/upgrade-plan.txt ]] || fail "missing /root/upgrade-plan.txt"
if ! grep -Eqi 'upgrade|version|up-to-date|up to date' /root/upgrade-plan.txt; then
  fail "upgrade-plan.txt does not look like kubeadm upgrade plan output"
fi
echo OK
