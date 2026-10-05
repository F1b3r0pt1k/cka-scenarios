Create a Pod named `nginx` with the image `nginx:1.27-alpine`.

Find which node the Pod was scheduled onto.

Drain that node so its Pods are evicted together. Do not remove the Pod with `kubectl delete pod`. Leave DaemonSet Pods in place, and allow the drain to remove Pods that have no controller.

When you are done, `nginx` must not be running.

## Details

The Pod has no controller. A drain refuses to delete that kind of Pod unless you force it, and it also refuses to touch DaemonSet Pods unless you tell it to ignore them.

`kubectl delete pod` removes only that one Pod and leaves the node schedulable. Draining cordons the node first, which is part of what this step checks.

## Finished when

- Pod `nginx` does not exist.
- The node that ran it has `.spec.unschedulable` set.

Docs: https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/
