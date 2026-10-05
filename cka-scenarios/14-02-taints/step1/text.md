Create a Pod named `web` from `/root/pod.yaml` using `nginx:1.27-alpine`.

Write the node name to `/root/pod-node.txt`.

## Details

Pod `web`, image `nginx:1.27-alpine`. Write only the node name into `/root/pod-node.txt`. That will be `node01` unless you pinned the Pod somewhere else. Later steps read this file.

## Finished when

The Pod is Ready and `/root/pod-node.txt` matches `spec.nodeName`.
