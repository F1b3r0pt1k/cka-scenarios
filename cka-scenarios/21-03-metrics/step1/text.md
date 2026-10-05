Wait until `kubectl top pods -n stress` shows memory for all three Pods.

Write the name of the Pod that is using the most memory to `/root/highest-memory.txt`. The file should contain only the Pod name.

## Details

Metrics Server is installed. Namespace `stress` has `mem-low`, `mem-mid`, and `mem-high`. Each runs `stress` with a different `--vm-bytes` value. `kubectl top pods -n stress` can take a minute to show memory for all three. Wait until you see three rows.

Write only the Pod name that is using the most memory to `/root/highest-memory.txt`.

## Finished when

The file contains `mem-high` and `kubectl top pods -n stress` returns at least three Pods.

Docs: https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/
