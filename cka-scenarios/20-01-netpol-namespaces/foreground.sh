#!/bin/bash
echo "Preparing the two-node lab..."
for _ in $(seq 1 180); do
  if [[ -f /tmp/setup-done ]]; then
    echo "Lab environment is ready."
    exit 0
  fi
  sleep 2
done
echo "Setup is still finishing. Continue with the task; objects appear when preparation completes."
exit 0
