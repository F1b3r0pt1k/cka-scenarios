Write the output of the node listing (include wide output) and the kubeadm version into `/root/cluster-version.txt`.

Both node names and a Kubernetes version must appear in that file.

## Details

`kubectl get nodes -o wide` shows the kubelet version on each node. `kubeadm version` shows the kubeadm build on this host. Put both outputs in the same file. The check looks for the names `controlplane` and `node01` and a version number.

## Finished when

`/root/cluster-version.txt` mentions both nodes and a version such as `v1.33.1`.

Docs: https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-version/
