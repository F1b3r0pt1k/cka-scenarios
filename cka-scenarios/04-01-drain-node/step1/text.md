Create a Pod named `nginx` with the image `nginx:1.27-alpine`.

Find which node the Pod was scheduled onto.

Drain that node so its Pods are evicted together. Do not remove the Pod with `kubectl delete pod`. Leave DaemonSet Pods in place, and allow the drain to remove Pods that have no controller.

When you are done, `nginx` must not be running.
