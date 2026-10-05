Identify everything that stops `node01` from accepting Pods and fix it.

`node01` must be Ready and schedulable.

Create a Pod named `node-check` using `nginx:1.27-alpine` and pin it to `node01` with `nodeName`. It must be Running.

## Details

Two things were done to `node01`:

- its kubelet was stopped
- the node was cordoned

`kubectl get nodes` shows `NotReady` and `SchedulingDisabled`. `kubectl describe node node01` shows the taint added by the cordon. The kubelet service is on the worker, not on the control plane. Use `ssh node01` or the node01 terminal and start `kubelet` with systemd. Then, from the control plane, uncordon `node01`.

Pod `node-check`, image `nginx:1.27-alpine`, `nodeName: node01`. It stays Pending until the node is Ready and schedulable.

## Finished when

`node01` is Ready and schedulable, and `node-check` is Ready with `nodeName` `node01`.

Docs: https://kubernetes.io/docs/tasks/debug/debug-cluster/crictl/
