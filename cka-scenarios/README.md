# CKA practice scenarios

Hands-on [Killercoda](https://killercoda.com/creators) scenarios for the sample exercises in *Certified Kubernetes Administrator (CKA) Study Guide*, 2nd edition. Chapters 1–3 have no exercises, so the course starts at chapter 4. Each exercise is its own scenario, ordered by chapter in `structure.json`.

Every scenario uses the two-node image `kubernetes-kubeadm-2nodes` (`controlplane` at 172.30.1.2 and `node01` at 172.30.2.2) and opens in Killercoda's exam desktop (`interface.layout` is `exam-desktop`). Each step has a Check button. The check passes when its script exits 0.

The preparation script waits until setup finishes and then returns you to the same shell. It does not exit the terminal. `k` is `kubectl`, `$do` is `--dry-run=client -o yaml`, and `$now` is `--force --grace-period=0`, which matches the usual exam shortcuts. Each step lists the exact object names, the files the check reads, and a documentation link.

Tasks are written as generic exam-style work. They do not depend on the book's Vagrant labs or container images. A few labs install a standard manifest at startup (ingress-nginx, NGINX Gateway Fabric, Metrics Server, local-path-provisioner) or copy `etcdctl` onto the control plane.

## Publish

1. Push this directory to GitHub. Killercoda reads a repository, not a local folder.
2. In your Killercoda creator profile, add that repository and branch.
3. If the repository root is this directory, the course is the repo. If this directory lives inside a larger repo, Killercoda treats `cka-scenarios` as a course and uses `structure.json` for order.

Pushing the branch updates the published scenarios.

## Labs that differ from a local four-node install

| Topic | What this lab does |
| --- | --- |
| Cluster create / upgrade | The two-node cluster is already installed. The upgrade lab records versions, runs `kubeadm upgrade plan`, drains `node01`, then uncordons it. |
| etcd | `etcdctl` and `etcdutl` are copied from the etcd static Pod. The restore goes to `/var/bak` and does not replace the live data directory. |
| Helm | Installs the small `podinfo` chart so the repo, install, and uninstall flow finishes within the session. |
| CRDs | Uses a short Database CRD and a Backup CRD instead of the MongoDB community operator CRD. |
| Autoscaling and metrics | Metrics Server is installed. CPU and memory requests are sized for this cluster. |
| Ingress and Gateway | ingress-nginx or NGINX Gateway Fabric (GatewayClass `nginx`) is installed before the task starts. |
| Dynamic volumes | The `local-path` StorageClass is installed. It waits for the first consumer. |
| Network policy | Checks open and blocked connections. The cluster CNI has to enforce `NetworkPolicy`. |
| Broken worker | `node01` is cordoned and its kubelet is stopped. Use the node01 terminal for `systemctl`. |
| Broken scheduler | The scheduler static Pod image is set to `v1.99.0`. A `.backup` copy of the manifest is left beside it. |

## Scenarios

| Scenario | Chapter exercise |
| --- | --- |
| 04.1 Drain a node | Evict a Pod by draining its node |
| 04.2 Prepare a worker for upgrade | Version, upgrade plan, drain, uncordon |
| 05.1 Identify the etcd version | Read the etcd static Pod version |
| 05.2 Back up and restore etcd | Snapshot to `/opt/etcd.bak`, restore to `/var/bak` |
| 06.1 Aggregate ClusterRoles | User `devuser`, aggregated ClusterRole |
| 06.2 Call the API as a ServiceAccount | List is allowed, delete is forbidden |
| 07.1 Install and use a CRD | Database custom resource |
| 07.2 Define a Backup custom resource | Backup object `nginx-backup` |
| 08.1 Install and remove a Helm release | `podinfo` chart |
| 08.2 Apply manifests and render a Kustomize overlay | Directory apply, then namespace `t012` |
| 09.1 Run a Pod in a namespace | nginx plus environment variables |
| 09.2 Set a container command | One-shot command, then a long-running loop |
| 10.1 Mount a ConfigMap as a volume | File from `/root/application.yaml` |
| 10.2 Expose a Secret as an environment variable | `DB_PASSWORD` from a Secret |
| 11.1 Fix a Deployment manifest | Selector does not match the Pod labels |
| 11.2 Roll a Deployment forward and back | Image change, change-cause, rollback |
| 12.1 Scale a Deployment from a manifest | 3 replicas, then 8 |
| 12.2 Configure a HorizontalPodAutoscaler | CPU 75% and memory 60% |
| 13.1 Set container requests and limits | CPU, memory, ephemeral storage |
| 13.2 Enforce a ResourceQuota | Oversized Pod rejected, smaller Pod admitted |
| 13.3 Observe a LimitRange | Defaults, a rejected Pod, an accepted Pod |
| 14.1 Schedule with nodeSelector and node affinity | `color=green` or `color=red` |
| 14.2 Taint a node and tolerate it | `exclusive=yes:NoExecute` |
| 15.1 Share an emptyDir between containers | File written in one container, read in the other |
| 16.1 Bind a Pod to a static PersistentVolume | hostPath `/var/logs` survives a new Pod |
| 16.2 Provision a volume with a StorageClass | `local-path`, then a Pod mounts it |
| 17.1 Expose two ports with a NodePort Service | Node port 30080 |
| 17.2 Discover a Service from another Deployment | Frontend reaches `database-service:3306` |
| 18.1 Route two paths through one Ingress | Host `app.example.com` |
| 18.2 Shift a fraction of traffic with a canary Ingress | 20% to the green Service |
| 19.1 Route traffic with a Gateway and HTTPRoute | `/web` and `/api` |
| 19.2 Attach routes from another namespace | ReferenceGrant from `staging` |
| 20.1 Limit traffic between namespaces | `team-alpha` to `team-beta` only |
| 20.2 Lock down a three-tier application | Frontend, backend, and database |
| 21.1 Fix a Pod that cannot write its marker file | Missing writable mount |
| 21.2 Fix a Service that has no endpoints | Selector and target port |
| 21.3 Find the Pod using the most memory | `kubectl top` in namespace `stress` |
| 22.1 Restore a worker that will not take Pods | Kubelet stopped and node cordoned |
| 22.2 Repair the kube-scheduler static Pod | Scheduler image will not pull |
