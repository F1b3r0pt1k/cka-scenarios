#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

if helm status frontend -n monitoring >/dev/null 2>&1; then
  fail "release frontend is still installed"
fi
echo OK
