This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. The worker is the node that accepts ordinary Pods. The control plane is tainted so it does not run application Pods.

This hosted cluster is already installed at the current Kubernetes release, so the lab does not swap package versions. The workflow is the one you use when upgrading a worker: inspect versions, review `kubeadm upgrade plan`, drain the worker, then make it schedulable again.
