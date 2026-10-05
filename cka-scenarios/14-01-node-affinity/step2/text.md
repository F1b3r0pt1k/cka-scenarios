Replace `web` so it is required to run on a node whose `color` is `green` or `red`. Use node affinity rather than a node selector.

The Pod should be running on one of those nodes.

## Details

`nodeSelector` cannot be changed on a running Pod. Delete `web` and create it again. Use required node affinity (`requiredDuringSchedulingIgnoredDuringExecution`), key `color`, operator `In`, values `green` and `red`.

The control plane is still tainted, so the Pod should still run on `node01`, which is green. Either color is acceptable to the check as long as the affinity rule lists both.

## Finished when

Pod `web` is Ready on a node labeled green or red, and the required affinity expression is `color In green red`.

Docs: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity
