This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`. Switch to the **node01** terminal when you need to run commands on the worker itself.

New Pods stay Pending. A control plane component on this node is not healthy.

Static Pod manifests live in `/etc/kubernetes/manifests`. A copy of the original scheduler manifest was saved beside the live file with a `.backup` suffix. Compare that file, or the image tags of the other control plane Pods, with the manifest that kubelet is using.
