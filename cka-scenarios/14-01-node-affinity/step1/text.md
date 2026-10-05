Label the nodes as described above.

Write `/root/pod.yaml` for a Pod named `web` using `nginx:1.27-alpine`. Use a node selector so it runs only on `color=green`. Create the Pod and confirm the node.

## Details

Label `node01` with `color=green` and `controlplane` with `color=red`. Write `/root/pod.yaml` for Pod `web`, image `nginx:1.27-alpine`, with `nodeSelector: color: green`. The Pod lands on `node01`. It cannot land on the control plane without a toleration for the control-plane taint.

## Finished when

Both nodes have those color labels, Pod `web` is Ready on the green node, and its node selector color is `green`.

Docs: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector
