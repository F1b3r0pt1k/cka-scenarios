This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`.

An ingress-nginx controller is already installed and provides the IngressClass `nginx`. Its Service is `ingress-nginx-controller` in the `ingress-nginx` namespace.

Call the Ingress by sending `Host: app.example.com` to that Service. You do not need a public DNS name.
