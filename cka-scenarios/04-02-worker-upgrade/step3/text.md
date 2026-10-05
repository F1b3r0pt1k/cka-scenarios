Drain `node01` so it will not accept new Pods and so existing workload Pods are evicted. Leave DaemonSet Pods running, and allow removal of Pods that are not managed by a controller. If drain stops on emptyDir data, allow that data to be deleted.

`node01` should stay unschedulable at the end of this step.

## Details

Drain only `node01`. Useful flags for this node:

- ignore DaemonSets, or the drain stops on `kube-proxy` and the CNI agent
- delete emptyDir data if the command says it is blocked on that
- force removal of Pods with no controller

Cordon alone is not enough. After the drain, `node01` should have no Pods except DaemonSet Pods.

## Finished when

- `node01` is unschedulable.
- Every remaining Pod on `node01` belongs to a DaemonSet.

Docs: https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/
