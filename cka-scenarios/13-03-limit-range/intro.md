This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`. The control plane is tainted.

`/root/limitrange.yaml` creates namespace `limited` and a LimitRange.

For every container the range sets:

- minimum CPU `200m`
- maximum CPU `500m`
- default CPU request `200m`
- default CPU limit `500m`

Apply that file before you create Pods. Use image `nginx:1.27-alpine` for each Pod.
