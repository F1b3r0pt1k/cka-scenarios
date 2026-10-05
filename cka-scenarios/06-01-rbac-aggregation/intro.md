This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. The worker is the node that accepts ordinary Pods. The control plane is tainted so it does not run application Pods.

A client certificate for the user `devuser` is already on the control plane. Use the kubeconfig context `devuser-context` when you need to act as that user.

Namespaces `development` and `production` already exist.
